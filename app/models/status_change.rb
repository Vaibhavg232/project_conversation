class StatusChange < ApplicationRecord
  belongs_to :project
  has_one :project_event, as: :eventable, dependent: :destroy

  validates :old_status, presence: true
  validates :new_status, presence: true
  validates :project_id, presence: true

  def status_change_text
    "Status changed from #{old_status} to #{new_status}"
  end
end
