class User < ActiveRecord::Base
  validates :name, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private

  def self.valid_session_token? token
    User.find_by(token: token) ? true : false
  end

  def self.get_session_token email
    User.find_by(email: email).token
  end
end
