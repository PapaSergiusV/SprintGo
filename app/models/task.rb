class Task < ApplicationRecord
  belongs_to :sprint
  belongs_to :project
  validates :name, presence: true

  before_create do
    self.state ||= 'To Do'
  end
end
