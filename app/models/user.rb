class User < ApplicationRecord
  has_secure_password
  before_create :generate_verification_token

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }, format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[[:^alnum:]])/, message: "must include at least one lowercase letter, one uppercase letter, one digit, and one special character" }
  validates :password_confirmation, presence: true
  private

  def generate_verification_token
    self.verification_token = SecureRandom.hex(10)
  end
end
