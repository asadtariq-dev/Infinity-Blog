# frozen_string_literal: true

class Author < ApplicationRecord
  before_save { self.email = email.downcase }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :confirmable

  enum :role, %i[author moderator admin], default: 0
  validates :first_name, :last_name, :email, :password, presence: true
  validates :email, uniqueness: true, format: { with: Devise.email_regexp }
  validates :first_name, :last_name, length: { within: 3..10 }
  validates :password, length: { within: 6..12 }

  has_many :posts, dependent: :destroy
  has_many :suggestions, dependent: :destroy
end
