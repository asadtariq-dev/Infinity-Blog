# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Like, type: :model do
  let(:author) { create(:author) }
  let(:post) do
    create(:post, author_id: author.id, header_image: fixture_file_upload(Rails.root.join('spec/fixtures/a1.jpeg')))
  end
  let(:like) { create(:like, likeable: post, author_id: author.id) }
  let(:other_like) { build(:like, likeable: post, author_id: like.author_id) }

  describe 'association tests' do
    it { is_expected.to belong_to(:author) }
    it { is_expected.to belong_to(:likeable) }
  end

  describe 'validation test' do
    context 'when liked by same author twice' do
      it 'ensures uniqueness of author_id within scope of likeable_id and likeable_type' do
        other_like.valid?
        expect(other_like.errors.full_messages.to_sentence).to include('Author has already been taken')
      end
    end
  end
end
