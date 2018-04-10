class Promotion < ApplicationRecord
  validates :subject, presence: true
  validates :message, presence: true
end
