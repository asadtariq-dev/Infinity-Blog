# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Suggestion, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:post) }
    it { is_expected.to belong_to(:author) }
    it { is_expected.to belong_to(:parent).class_name('Suggestion').optional(true) }
    it { is_expected.to have_many(:suggestions).with_foreign_key(:parent_id).dependent(:destroy).inverse_of(:parent) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_length_of(:content).is_at_least(2).is_at_most(200) }
  end
end
