class User < ApplicationRecord
  has_many :roles, dependent: :nullify
end
