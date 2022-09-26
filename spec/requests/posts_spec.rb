require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:current_author) { create(:author) }
  let(:other_author) { create(:author, email: 'test3@rspec.com') }
  let(:unknown_id) { '673-322' }

  context 'when author is NOT signed in' do
    it 'redirects to sigin page' do
      get '/posts/new'
      expect(response).to redirect_to('/authors/sign_in')
    end
  end

  context 'when author is signed in' do
    before do
      sign_in current_author
    end

    describe 'create action' do
      it 'creates a post' do
        post posts_path,
             params: { post: { title: 'title', description: 'this is description', content: '<div><strong>This is content of post</strong></div>', status: 'pending', author_id: current_author.id,
                               header_image: fixture_file_upload(Rails.root.join('spec/fixtures/a1.jpeg')) } }
        expect(flash[:notice]).to eq('Post has been created')
      end

      it 'render new template again if no header image is provided' do
        post posts_path,
             params: { post: { title: 'title', description: 'this is description', content: '<div><strong>This is content of post</strong></div>', status: 'pending', author_id: current_author.id } }
        expect(response).to render_template(:new)
      end
    end

    describe 'destroy action' do
      let(:post) do
        create(:post, status: 'pending', author_id: current_author.id,
                      header_image: fixture_file_upload(Rails.root.join('spec/fixtures/a1.jpeg'), content: '<div><strong>This is content of post</strong></div>'))
      end
      let(:other_post) do
        create(:post, status: 'pending', author_id: other_author.id,
                      header_image: fixture_file_upload(Rails.root.join('spec/fixtures/a1.jpeg'), content: '<div><strong>This is content of post</strong></div>'))
      end

      it 'deletes a post' do
        delete post_path(post)
        expect(flash[:alert]).to eq('Post has been Deleted')
      end

      it 'gives record not found alert if unknown post id is given' do
        delete post_path(unknown_id)
        expect(flash[:alert]).to eq('Record Not Found')
      end

      it 'gives not authorized alert if tries to delete other authors post' do
        delete post_path(other_post)
        expect(flash[:alert]).to eq('Your are not authorized for this action')
      end
    end

    describe 'index action' do
      it 'redirects to home page after getting posts from author index' do
        get posts_path
        expect(response).to redirect_to('/')
      end
    end

    describe 'show action' do
      let(:published_post) do
        create(:post, status: 'published', author_id: other_author.id,
                      header_image: fixture_file_upload(Rails.root.join('spec/fixtures/a1.jpeg'), content: '<div><strong>This is content of post</strong></div>'))
      end

      let(:unpublished_post) do
        create(:post, status: 'unpublished', author_id: other_author.id,
                      header_image: fixture_file_upload(Rails.root.join('spec/fixtures/a1.jpeg'), content: '<div><strong>This is content of post</strong></div>'))
      end

      it 'shows the post if post id is correct and is published' do
        get post_path(published_post)
        expect(response).to render_template(:show)
      end

      it 'gives post unpublished alert if the requested post is currently unpublished' do
        get post_path(unpublished_post)
        expect(flash[:notice]).to eq('Post has been unpublished')
      end

      it 'gives record not found alert if unknown post id is given' do
        get post_path(unknown_id)
        expect(flash[:alert]).to eq('Record Not Found')
      end
    end

    describe 'edit action' do
      let(:post3) do
        create(:post, status: 'unpublished', author_id: current_author.id,
                      header_image: fixture_file_upload(Rails.root.join('spec/fixtures/a1.jpeg'), content: '<div><strong>This is content of post</strong></div>'))
      end

      it 'renders the edit template' do
        get edit_post_path(post3)
        expect(response).to render_template(:edit)
      end

      it 'gives record not found alert if unknown post id is given' do
        get edit_post_path(unknown_id)
        expect(flash[:alert]).to eq('Record Not Found')
      end
    end

    describe 'new action' do
      it 'renders the new template' do
        get new_post_path
        expect(response).to render_template(:new)
      end
    end

    describe 'submit action' do
      let(:post4) do
        create(:post, status: 'unpublished', author_id: current_author.id,
                      header_image: fixture_file_upload(Rails.root.join('spec/fixtures/a1.jpeg'), content: '<div><strong>This is content of post</strong></div>'))
      end

      let(:post5) do
        create(:post, status: 'pending', author_id: current_author.id,
                      header_image: fixture_file_upload(Rails.root.join('spec/fixtures/a1.jpeg'), content: '<div><strong>This is content of post</strong></div>'))
      end

      it 'submits a post' do
        get submit_post_path(post4.id)
        expect(flash[:notice]).to eq 'Post has been submitted'
      end

      it 'cancel post submission' do
        put submit_post_path(post5.id)
        expect(flash[:alert]).to eq 'Submission cancelled'
      end
    end

    describe 'update action' do
      let(:post3) do
        create(:post, status: 'unpublished', author_id: current_author.id,
                      header_image: fixture_file_upload(Rails.root.join('spec/fixtures/a1.jpeg'), content: '<div><strong>This is content of post</strong></div>'))
      end

      it 'updates a post title' do
        patch post_path(post3.id), params: { post: { title: 'title updated' } }
        expect(flash[:notice]).to eq 'Post has been updated'
      end

      it 'gives record not found alertif unknown post id is given' do
        patch post_path(unknown_id), params: { post: { title: 'title updated' } }
        expect(flash[:alert]).to eq 'Record Not Found'
      end

      it 'gives alert message if invalid values are given' do
        patch post_path(post3.id), params: { post: { title: nil } }
        expect(flash[:alert]).to eq 'Invalid values for post'
      end
    end
  end
end
