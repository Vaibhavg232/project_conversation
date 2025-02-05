class Project < ApplicationRecord
  has_many :project_events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :status_changes, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :current_status, presence: true

  def conversation_history
    project_events.includes(:eventable).order(created_at: :asc)
  end
end
