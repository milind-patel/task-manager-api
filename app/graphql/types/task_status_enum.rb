module Types
  class TaskStatusEnum < Types::BaseEnum
    # Change graphql_name to remove "Enum"
    graphql_name "TaskStatus"

    value "PENDING", value: "pending"
    value "IN_PROGRESS", value: "in_progress"
    value "COMPLETED", value: "completed"
  end
end
