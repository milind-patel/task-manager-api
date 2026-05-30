class Task < ApplicationRecord
  belongs_to :user

  enum :status, {
    pending: 0,
    in_progress: 1,
    completed: 2
  }

  enum :priority, {
    low: 0,
    medium: 1,
    high: 2
  }

  validates :title,
    presence: true,
    length: { maximum: 255 }
  validates :status, presence: true
  validates :priority, presence: true

  scope :by_status, ->(status) {
    where(status: status) if status.present?
  }

  scope :by_priority, ->(priority) {
    where(priority: priority) if priority.present?
  }

  scope :by_due_date, ->(date) {
    where(due_date: date) if date.present?
  }
end
