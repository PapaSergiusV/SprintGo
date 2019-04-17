class Task < ApplicationRecord
  belongs_to :sprint
  belongs_to :project
  validates :name, presence: true

  after_validation do
    self.done_time = Time.now.in_time_zone if state == 'Done'
  end

  before_create do
    self.state ||= 'To Do'
  end
end
