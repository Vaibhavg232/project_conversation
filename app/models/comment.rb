class Comment < ApplicationRecord
  belongs_to :project
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, -> { order(created_at: :asc) },
           class_name: "Comment",
           foreign_key: "parent_id",
           dependent: :destroy

  has_one :project_event, as: :eventable, dependent: :destroy

  validates :body, presence: true

  scope :top_level, -> { where(parent_id: nil) }
end
