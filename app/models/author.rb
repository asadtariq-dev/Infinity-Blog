# frozen_string_literal: true

class Author < ApplicationRecord
  before_save { self.email = email.downcase }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :confirmable

  validates :first_name, :last_name, :email, :password, presence: true
  validates :email, uniqueness: true, format: { with: Devise.email_regexp, message: 'Invalid email' }
  validates_length_of :first_name, :last_name, within: 3..10
  validates_length_of :password, within: 8..12

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :reports, dependent: :destroy
end
