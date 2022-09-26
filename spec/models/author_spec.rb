# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Author, type: :model do
  describe 'associations tests' do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
    it { is_expected.to have_many(:suggestions).dependent(:destroy) }
  end

  describe 'validation tests' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_length_of(:first_name).is_at_least(3).is_at_most(10) }
    it { is_expected.to validate_length_of(:last_name).is_at_least(3).is_at_most(10) }
  end

  describe 'enums test' do
    it { is_expected.to define_enum_for(:role).with_values(%i[author moderator admin]) }
  end
end
