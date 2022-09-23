# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Report, type: :model do
  let(:author) { create(:author) }
  let(:post) do
    create(:post, author_id: author.id, header_image: fixture_file_upload(Rails.root.join('spec/fixtures/a1.jpeg')))
  end
  let(:report) { described_class.create(reportable: post, author_id: author.id) }
  let(:other_report) { described_class.new(reportable: post, author_id: report.author_id) }

  describe 'association tests' do
    it { is_expected.to belong_to(:author) }
    it { is_expected.to belong_to(:reportable) }
  end

  describe 'validation test' do
    context 'when reported by same author twice' do
      it 'ensures uniqueness of author_id within scope of reportable_id and reportable_type' do
        other_report.valid?
        expect(other_report.errors.full_messages.to_sentence).to include('Author has already been taken')
      end
    end
  end
end
