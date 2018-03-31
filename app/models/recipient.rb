class Recipient < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :description, presence: true
  validates :account_number, presence: true
  validates :bank_code, presence: true
end
