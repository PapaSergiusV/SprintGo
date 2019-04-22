class Task < ApplicationRecord
  belongs_to :sprint
  belongs_to :project
  belongs_to :user
  validates :name, presence: true

  after_validation do
    self.done_time = Time.now.in_time_zone if state == 'Done'
  end

  def as_json(*)
    super(
      only: %i[id name about done_time project_id sprint_id state time],
      include: :user
    )
  end

  before_create do
    self.state ||= 'To Do'
  end
end
