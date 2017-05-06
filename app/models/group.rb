class Group < ApplicationRecord
  validates :email, presence: true
end
