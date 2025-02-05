class ProjectHeaderComponent < ViewComponent::Base
  attr_reader :project

  def initialize(project:)
    @project = project
  end

  private

  def status_classes
    case project.current_status
    when 'completed'
      'bg-green-100 text-green-800 border border-green-200'
    when 'in_progress'
      'bg-blue-100 text-blue-800 border border-blue-200'
    else
      'bg-yellow-100 text-yellow-800 border border-yellow-200'
    end
  end
end 