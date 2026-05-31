module Types
  class TaskPriorityEnum < Types::BaseEnum
    # Change graphql_name to remove "Enum"
    graphql_name "TaskPriority"

    value "LOW", value: "low"
    value "MEDIUM", value: "medium"
    value "HIGH", value: "high"
  end
end
