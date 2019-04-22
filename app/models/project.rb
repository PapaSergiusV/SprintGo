class Project < ApplicationRecord
  belongs_to :company
  has_many :project_roles, dependent: :destroy
  has_many :sprints, dependent: :destroy
  has_many :tasks, dependent: :destroy
  validates :name, presence: true

  def as_json(*)
    super(
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
    )
  end
end
