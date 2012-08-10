class User < ActiveRecord::Base
  attr_accessor :password #, :password_confirmation

  attr_accessible :name, :email,
                  :password, :password_confirmation

  validates :name,
           :presence => true,
      :length => { :minimum => 6, :maximum => 32}

  validates :name,
      presence: true,
      length: { maximum: 32 }


  validates :email,
      presence: true,
      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
      uniqueness: true #{ case_sensitive: true}

  validates :password,
      presence: true,
      confirmation: true,
      length:  { in: 6..40}

  validates :password_confirmation,
      presence: { :unless => lambda { self.password.nil? } }

  before_save :encrypt_password


  def has_password?(password)
    encrypted_password ==  hash_password(salt, password)
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    return user if user && user.has_password?(password)
    return nil
  end
  private

  def encrypt_password
    self.salt = make_salt if new_record?

    self.encrypted_password = hash_password(salt, password)
  end

  def make_salt
    secure_hash(SecureRandom.base64)
  end
  def hash_password(salt, password)
    secure_hash("#{salt}-#{password}")
  end

  def secure_hash(source)
    Digest::SHA2.hexdigest source
  end


end
