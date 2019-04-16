class Sprint < ApplicationRecord
  belongs_to :project
  has_many :tasks, dependent: :destroy
  validates :name, presence: true

  before_validation :set_period

  private

  def set_period
    self.period = "#{Time.now.in_time_zone} - #{deadline}"
  end
end
