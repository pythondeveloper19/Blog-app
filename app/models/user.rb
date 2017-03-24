class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessor :current_password
  attr_accessible :email, :password, :password_confirmation, :remember_me, :user_type, :avatar,:name, :provider, :uid, :image,:current_password
  # attr_accessible :title, :body
  validate :name, :presence => true
  has_many :posts
  has_many :comments
  has_many :likes
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  has_many :photos, :as => :photable
  
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name: data["name"],
          user_type: "blogger",
          provider: access_token.provider,
          email: data["email"],
          image: data["image"],
          uid: access_token.uid ,
          password: Devise.friendly_token[0,20]
        )
      end
    end
  end
  def self.find_for_facebook_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      user.user_type = "blogger"
    end
  end
 
end
