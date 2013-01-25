class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :api_key

  has_secure_password

  has_many :notes

  validates :email, :password, :password_confirmation, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i },
                    uniqueness: { case_sensitive: false }

  before_create :set_api_key


  def set_api_key
    api_key = Digest::MD5.hexdigest(email+DateTine.now.to_s)
  end
  alias :regenerate_api_key :set_api_key

end
