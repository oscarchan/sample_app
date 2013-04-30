class User < ActiveRecord::Base
  #attr_accessor :password, :password_confirmation   # auto defined by has_secure_password


  attr_accessible :name, :email,
                  :password, :password_confirmation,
                  :remember_token

  has_secure_password

  has_many :microposts, dependent: :destroy

  validates :name,
            :presence => true,
            :length => { :minimum => 6, :maximum => 32}

  validates :name,
            presence: true,
            length: { maximum: 32 }


  validates :email,
      presence: true,
      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
      uniqueness: true # { case_sensitive: false }

  validates :password,
      presence: true,
      confirmation: true,
      length:  { in: 6..40}

  validates :password_confirmation,
      presence: { :unless => lambda { self.password.nil? } }

  before_save lambda { |user| user.remember_token = SecureRandom.urlsafe_base64}


  def self.authenticate(email, password)
    user = User.find_by_email(email)
    return user.try(:authenticate, password) if user
  end

  def email=(email)
    canonical_email = email.downcase if email.respond_to? :downcase
    canonical_email ||= email

    write_attribute(:email, canonical_email)
  end



end
