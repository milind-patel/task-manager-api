module Types
  class TaskType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: true
    field :status, TaskStatusEnum, null: false
    field :priority, TaskPriorityEnum, null: false
    field :due_date, String, null: true
    field :created_at, String, null: false
    field :updated_at, String, null: false
  end
end
