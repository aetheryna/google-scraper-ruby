# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, format: URI::MailTo::EMAIL_REGEXP

  has_many :keywords, dependent: :destroy

  # the authenticate method from devise documentation
  def self.authenticate(email, password)
    password_params = password

    user = User.find_for_authentication(email: email)
    user&.valid_password?(password_params) ? user : nil
  end
end