require 'rails_helper'

RSpec.describe 'Authors', type: :request do
  let(:current_author) { create(:author) }
  let(:other_author) { create(:author, email: 'test2@rspec.com') }

  context 'when author is NOT signed in' do
    it 'redirects to sigin page if root_path is requested' do
      get '/'
      expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
    end

    it 'redirects to sigin page if author profile is requested' do
      get author_profile_path(current_author)
      expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
    end

    it 'redirects to sigin page if author destroy action is called' do
      delete author_registration_path
      expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
    end
  end

  context 'when author is signed in' do
    before do
      sign_in current_author
    end

    it 'shows the current author profile' do
      get author_profile_path(current_author)
      expect(response).to have_http_status(:success)
    end

    it 'destroys the current author' do
      delete author_registration_path
      expect(response).to have_http_status(:found)
    end

    it 'gives alert message when signed in author tries to go to other authors profile' do
      get author_profile_path(other_author)
      expect(flash[:alert]).to eq('You can only access your own profile')
    end
  end
end
