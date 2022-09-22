# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Comment, type: :model do
  let(:author) { create(:author) }

  let(:post) do
    create(:post, author_id: author.id, header_image: fixture_file_upload(Rails.root.join('spec/fixtures/a1.jpeg')))
  end

  let(:comment_without_image) do
    create(:comment, content: 'this is content', author_id: author.id, post_id: post.id)
  end

  let(:comment_with_image) do
    create(:comment, image: fixture_file_upload(Rails.root.join('spec/fixtures/a1.jpeg')), content: '', author_id: author.id, post_id: post.id)
  end

  let(:comment_with_image_and_content) do
    create(:comment, image: fixture_file_upload(Rails.root.join('spec/fixtures/a1.jpeg')), content: 'this is content', author_id: author.id, post_id: post.id)
  end

  let(:comment_without_image_and_content) do
    build(:comment, author_id: author.id, post_id: post.id)
  end

  describe 'association tests' do
    it { is_expected.to belong_to(:post) }
    it { is_expected.to belong_to(:author) }
    it { is_expected.to belong_to(:parent).class_name('Comment').optional(true) }
    it { is_expected.to have_one_attached(:image) }
    it { is_expected.to have_many(:comments).with_foreign_key(:parent_id).dependent(:destroy).inverse_of(:parent) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:reports).dependent(:destroy) }
  end

  describe 'validation tests' do
    it { is_expected.to validate_presence_of(:image) }
  end

  describe 'Scope tests' do
    context 'with comments that' do
      let(:comment_without_image) do
        create(:comment, content: 'this is content', author_id: author.id, post_id: post.id, parent_id: nil)
      end
      let(:comment_with_image) do
        create(:comment, content: 'this is content', author_id: author.id, post_id: post.id, parent_id: comment_without_image.id)
      end

      it 'have parent_id nil' do
        expect(post.comments.not_reply).to include(comment_without_image)
      end

      it 'do not have parent_id nil' do
        expect(post.comments.not_reply).not_to include(comment_with_image)
      end
    end
  end

  describe 'custom validation tests' do
    it 'creates a comment with some CONTENT and NO IMAGE' do
      expect(comment_without_image).to be_valid
    end

    it 'creates a comment with IMAGE and NO CONTENT' do
      expect(comment_with_image).to be_valid
    end

    it 'creates a comment with both IMAGE and CONTENT' do
      expect(comment_with_image_and_content).to be_valid
    end

    it 'ensures that comment has image or content' do
      comment_without_image_and_content.valid?
      expect(comment_without_image_and_content.errors.full_messages.to_sentence).to include('text or image must be present')
    end
  end
end