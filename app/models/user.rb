class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :api_key

  has_secure_password

  has_many :notes

  validates :email, :password, :password_confirmation, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i },
                    uniqueness: { case_sensitive: false }

  before_create :set_api_key

  def regenerate_api_key
    update_attribute(:api_key, set_api_key)
  end

  private
    def set_api_key
      self.api_key = Digest::MD5.hexdigest(email+DateTime.now.to_s)
    end

end
