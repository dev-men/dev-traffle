class AdminNotification < ApplicationRecord
  belongs_to :admin
  belongs_to :product
end
