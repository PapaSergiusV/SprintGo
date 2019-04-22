class Company < ApplicationRecord
  has_many :roles, dependent: :destroy
  has_many :projects, dependent: :destroy
  validates :name, presence: true, uniqueness: true

  def as_json(*)
    super(
      only: %i[id logo name phone created_at address about],
      include: [
        projects: {
          only: %i[id name about company_id],
          include: [
            :sprints,
            project_roles: {
              include: [
                role: {
                  include: :user
                }
              ]
            }
          ]
        }
      ]
    ).merge(workers: set_workers)
  end

  private

  def set_workers
    workers = []
    User.where(id: roles.pluck(:user_id).uniq).find_each do |w|
      workers.push(
        id: w.id,
        email: w.email,
        roles: roles.where(user_id: w.id).select(:id, :name)
      )
    end
    workers
  end
end
