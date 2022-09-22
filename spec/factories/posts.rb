# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { 'Title' }
    description { 'Description' }
    content { '<div><strong>This is content of post</strong></div>' }
    status { 'published' }
    published_at { Time.zone.now }
  end
end
