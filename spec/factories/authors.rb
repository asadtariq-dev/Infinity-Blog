# frozen_string_literal: true

FactoryBot.define do
  factory :author do
    email { 'test@test.com' }
    first_name { 'First' }
    last_name { 'Last' }
    role { 'author' }
    confirmed_at { Time.zone.now }
    password { '12345678' }
  end
end
