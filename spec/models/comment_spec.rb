require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:body) }
  end

  describe 'associations' do
    it { should belong_to(:project) }
    it { should belong_to(:parent).optional }
    it { should have_many(:replies).class_name('Comment').with_foreign_key('parent_id') }
  end
end
