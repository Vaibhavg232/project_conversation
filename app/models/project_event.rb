class ProjectEvent < ApplicationRecord
  belongs_to :project
  belongs_to :eventable, polymorphic: true
end
