require "rails_helper"

RSpec.describe ProjectShowComponent, type: :component do
  let(:project) { create(:project) }
  
  before do
    # Set default URL options for the test environment
    Rails.application.routes.default_url_options[:host] = 'example.com'
  end
  
  it "renders project details" do
    result = render_inline(described_class.new(project: project))
    
    expect(result.text).to include(project.title)
    expect(result.text).to include(project.description)
    expect(result.text).to include("Status: #{project.current_status.titleize}")
  end
end 