# frozen_string_literal: true

FactoryBot.define do
  factory :author do
    traits_for_enum :role, %w[author moderator admin]
    first_name { Faker::Name.name[3..12] }
    last_name { Faker::Name.name[3..12] }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    confirmed_at { Time.current }
  end
end
