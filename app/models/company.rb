class Company < ApplicationRecord
  has_many :roles, dependent: :destroy
  has_many :projects, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
