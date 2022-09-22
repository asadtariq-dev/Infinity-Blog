# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Post, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:author) }
    it { is_expected.to have_one_attached(:header_image) }
    it { is_expected.to have_rich_text(:content) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:reports).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:suggestions).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:header_image) }
    it { is_expected.to validate_length_of(:title).is_at_least(5).is_at_most(100) }
    it { is_expected.to validate_length_of(:description).is_at_least(5).is_at_most(200) }
  end
end
