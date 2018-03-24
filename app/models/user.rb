class User < ApplicationRecord
  has_many :products, as: :imageable
  has_many :tickets
  has_many :carts
  has_many :notifications
  acts_as_token_authenticatable
  validates :first_name, presence: true
  #validates :last_name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers:  [:facebook, :twitter]


  def self.from_omniauth(auth)
    @u = User.find_by_email(auth.info.email)
    if @u == nil
      where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.uid = auth.uid
        user.provider = auth.provider
        user.first_name = auth.extra.raw_info.first_name
        user.last_name = auth.extra.raw_info.last_name
        user.gender = auth.extra.raw_info.gender
        user.image_url = auth.info.image + "?height=500"
        user.save!
      end
    else
      @u.provider = auth.provider
      @u.uid = auth.uid
      @u.first_name = auth.extra.raw_info.first_name
      @u.last_name = auth.extra.raw_info.last_name
      @u.gender = auth.extra.raw_info.gender
      @u.image_url = auth.info.image + "?height=500"
      @u.save!
      return @u
    end
  end

  def self.from_omniauth_twitter(auth)
    @u = User.find_by_email(auth.info.email)
    if @u == nil
      where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.uid = auth.uid
        user.provider = auth.provider
        @name = auth.info.name.gsub(/\s+/m, ' ').strip.split(" ")
        user.first_name = @name[0]
        if @name.size > 0
          user.last_name = @name[1]
        end
        user.image_url = auth.info.image
        user.save!
      end
    else
      @u.provider = auth.provider
      @u.uid = auth.uid
      @name = auth.info.name.gsub(/\s+/m, ' ').strip.split(" ")
      @u.first_name = @name[0]
      if @name.size > 0
        @u.last_name = @name[1]
      end
      @u.image_url = auth.info.image
      @u.save!
      return @u
    end
  end


  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
