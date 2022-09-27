# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authors', type: :request do
  let(:current_author) { create(:author, :author) }
  let(:other_author) { create(:author, :author, email: 'test2@rspec.com') }

  context 'when author is NOT signed in' do
    describe '#root' do
      it 'redirects to sigin page' do
        get root_path
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
      end
    end

    describe '#show' do
      it 'redirects to sigin page' do
        get author_profile_path(current_author)
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
      end
    end
  end

  describe 'when author is signed in' do
    before do
      sign_in current_author
    end

    describe '#show' do
      context 'when current author profile is requested' do
        it 'shows the current author profile' do
          get author_profile_path(current_author)
          expect(response).to have_http_status(:success)
        end
      end

      context 'when other authors profile is requested' do
        it 'shows alert message' do
          get author_profile_path(other_author)
          expect(flash[:alert]).to eq('You can only access your own profile')
        end
      end
    end
  end
end
