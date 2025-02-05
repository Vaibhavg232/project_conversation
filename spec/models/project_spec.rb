require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:current_status) }
  end

  describe 'associations' do
    it { should have_many(:project_events).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
  end

  describe '#conversation_history' do
    let(:project) { create(:project) }
    let!(:old_comment) { create(:comment, project: project) }
    let!(:new_comment) { create(:comment, project: project) }
    let!(:old_event) { create(:project_event, project: project, eventable: old_comment, created_at: 1.day.ago) }
    let!(:new_event) { create(:project_event, project: project, eventable: new_comment, created_at: Time.current) }

    it 'returns events in chronological order' do
      expect(project.conversation_history).to eq([ old_event, new_event ])
    end
  end
end
