class Contact < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :phone_no, presence: true
  validates :message, presence: true
end
