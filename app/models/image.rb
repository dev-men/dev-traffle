class Image < ApplicationRecord
  validates :avatar, presence: true
  belongs_to :product

  attr_accessor :avatar, :avatar_cache, :remove_avatar
  has_attached_file :avatar,
  styles: { medium: "250x250#", thumb: "150x150#" },
  default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  def avatar_url
    avatar.url(:original)
  end
end
