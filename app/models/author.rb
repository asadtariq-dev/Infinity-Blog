# frozen_string_literal: true

class Author < ApplicationRecord
  enum :role, { author: 0, moderator: 1, admin: 2 }, default: 0

  has_many :posts, dependent: :destroy
  has_many :suggestions, dependent: :destroy

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true, format: { with: Devise.email_regexp }
  validates :first_name, :last_name, length: { within: 3..10 }
  # validates :password, length: { within: 6..12 }

  before_save { self.email = email.downcase }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :confirmable
end
