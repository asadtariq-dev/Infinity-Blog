# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:current_author) { create(:author, :author) }
  let(:sign_in_required) { 'You need to sign in or sign up before continuing.' }
  let(:other_author) { create(:author, :author, email: 'test3@rspec.com') }
  let(:unknown_id) { '673-322' }
  let(:post_params) do
    { title: 'title', description: 'this is description', content: '<div><strong>This is content of post</strong></div>', status: 'pending', author_id: current_author.id,
      header_image: fixture_file_upload(Rails.root.join('spec/fixtures/a1.jpeg')) }
  end

  def post_params_without_image
    { title: 'title', description: 'this is description', content: '<div><strong>This is content of post</strong></div>', status: 'pending', author_id: current_author.id }
  end

  def unpublished_post
    create(:post, :unpublished, author_id: current_author.id,
                                header_image: fixture_file_upload(Rails.root.join('spec/fixtures/a1.jpeg'), content: '<div><strong>This is content of post</strong></div>'))
  end

  def pending_post
    create(:post, :pending, author_id: current_author.id,
                            header_image: fixture_file_upload(Rails.root.join('spec/fixtures/a1.jpeg'), content: '<div><strong>This is content of post</strong></div>'))
  end

  def published_post
    create(:post, :published, author_id: current_author.id,
                              header_image: fixture_file_upload(Rails.root.join('spec/fixtures/a1.jpeg'), content: '<div><strong>This is content of post</strong></div>'))
  end

  describe 'when author is NOT signed in' do
    describe '#index' do
      it 'redirects to sigin page' do
        get posts_path
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#new' do
      it 'redirects to sigin page' do
        get new_post_path
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#show' do
      it 'redirects to sigin page' do
        get post_path(published_post.id)
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#destroy' do
      it 'redirects to sigin page' do
        delete post_path(published_post.id)
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#update' do
      it 'redirects to sigin page' do
        patch post_path(published_post.id)
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#create' do
      it 'redirects to sigin page' do
        post posts_path
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#submit' do
      it 'redirects to signin page' do
        get submit_post_path(unpublished_post.id)
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end
  end

  describe 'when author is signed in' do
    before do
      sign_in current_author
    end

    describe '#create' do
      context 'when valid post is given' do
        it 'creates a post' do
          post posts_path, params: { post: post_params }
          expect(flash[:notice]).to eq('Post has been created')
        end
      end

      context 'when header image is not given' do
        it 're-renders new template and post not created' do
          post posts_path, params: { post: post_params_without_image }
          expect(response).to render_template(:new)
        end
      end
    end

    describe '#destroy' do
      def other_post
        create(:post, :published, author_id: other_author.id,
                                  header_image: fixture_file_upload(Rails.root.join('spec/fixtures/a1.jpeg'), content: '<div><strong>This is content of post</strong></div>'))
      end

      def own_post
        create(:post, :published, author_id: current_author.id,
                                  header_image: fixture_file_upload(Rails.root.join('spec/fixtures/a1.jpeg'), content: '<div><strong>This is content of post</strong></div>'))
      end

      context 'when own post is given' do
        it 'deletes a post' do
          delete post_path(own_post)
          expect(flash[:alert]).to eq('Post has been Deleted')
        end
      end

      context 'when unknown post ID is given' do
        it 'shows record not found alert' do
          delete post_path(unknown_id)
          expect(flash[:alert]).to eq('Record Not Found')
        end
      end

      context 'when other author post is given' do
        it 'shows not authorized alert' do
          delete post_path(other_post)
          expect(flash[:alert]).to eq('Your are not authorized for this action')
        end
      end
    end

    describe '#index' do
      context 'when posts_path is requested' do
        it 'redirects to home page' do
          get posts_path
          expect(response).to redirect_to(root_path)
        end
      end
    end

    describe '#show' do
      context 'when published post is given' do
        it 'renders show action of post' do
          get post_path(published_post)
          expect(response).to render_template(:show)
        end
      end

      context 'when unpublished post is given' do
        it 'gives post unpublished alert' do
          get post_path(unpublished_post)
          expect(flash[:notice]).to eq('Post has been unpublished')
        end
      end

      context 'when unknown post ID is given' do
        it 'gives record not found alert' do
          get post_path(unknown_id)
          expect(flash[:alert]).to eq('Record Not Found')
        end
      end
    end

    describe '#edit' do
      context 'when own post is given' do
        it 'renders the edit template' do
          get edit_post_path(published_post)
          expect(response).to render_template(:edit)
        end
      end

      context 'when unknown post ID is given' do
        it 'gives record not found alert' do
          get edit_post_path(unknown_id)
          expect(flash[:alert]).to eq('Record Not Found')
        end
      end
    end

    describe '#new' do
      context 'when new post path is requested' do
        it 'renders the new template' do
          get new_post_path
          expect(response).to render_template(:new)
        end
      end
    end

    describe '#submit' do
      context 'when unpublished post is given' do
        it 'submits a post' do
          get submit_post_path(unpublished_post.id)
          expect(flash[:notice]).to eq 'Post has been submitted'
        end
      end

      context 'when submitted post is given' do
        it 'cancel post submission' do
          put submit_post_path(pending_post.id)
          expect(flash[:alert]).to eq 'Submission cancelled'
        end
      end
    end

    describe '#update' do
      context 'when own post is given' do
        it 'updates a post' do
          patch post_path(published_post.id), params: { post: { title: 'title updated' } }
          expect(flash[:notice]).to eq 'Post has been updated'
        end
      end

      context 'when unknown post ID is given' do
        it 'gives record not found alert' do
          patch post_path(unknown_id), params: { post: { title: 'title updated' } }
          expect(flash[:alert]).to eq 'Record Not Found'
        end
      end

      context 'when invalid post params are given' do
        it 'gives invalid values alert' do
          patch post_path(published_post.id), params: { post: { title: nil } }
          expect(flash[:alert]).to eq 'Invalid values for post'
        end
      end
    end
  end
end
