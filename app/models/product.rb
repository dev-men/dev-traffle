class Product < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  has_many :images
  has_many :tickets
  has_many :carts
  has_many :notifications

  validates :title, presence: true
  validates :title, length: {minimum: 10}
  validates :category, presence: true
  validates :total_tickets, presence: true
  validates :short_description, presence: true
  validates :short_description, length: {minimum: 30}
  validates :long_description, presence: true
  validates :long_description, length: {minimum: 30}
  validates :images, presence: true
  validates :price, presence: true

  #validates_datetime :count_down, :after => lambda { Time.current }# + 30.days}
  accepts_nested_attributes_for :images
  validates_associated :images
end
