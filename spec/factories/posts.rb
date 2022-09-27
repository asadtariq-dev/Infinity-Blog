# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    traits_for_enum :status, %w[unpublished pending published]
    title { Faker::Lorem.paragraph(sentence_count: 1) }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
    published_at { Time.zone.now }
  end
end
