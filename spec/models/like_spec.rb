# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Like, type: :model do
  let(:author) { create(:author) }
  let(:post) do
    create(:post, author_id: author.id, header_image: fixture_file_upload(Rails.root.join('spec/fixtures/a1.jpeg')))
  end
  let(:like) { described_class.create(likeable: post, author_id: author.id) }
  let(:other_like) { described_class.new(likeable: post, author_id: like.author_id) }

  describe 'association tests' do
    it { is_expected.to belong_to(:author) }
    it { is_expected.to belong_to(:likeable) }
  end
end
