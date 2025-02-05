require 'rails_helper'

RSpec.describe StatusChange, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:old_status) }
    it { should validate_presence_of(:new_status) }
  end

  describe 'associations' do
    it { should belong_to(:project) }
  end
end 