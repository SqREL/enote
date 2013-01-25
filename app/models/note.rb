class Note < ActiveRecord::Base
  attr_accessible :body, :title, :api_key, :user_id

  belongs_to :user

  validates :body, :title, presence: true

end
