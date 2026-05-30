module Types
  class QueryType < Types::BaseObject
    # Get all tasks with optional filters
    field :tasks, [ Types::TaskType ], null: false do
      argument :status, Types::TaskStatusEnum,
        required: false
      argument :priority, Types::TaskPriorityEnum,
        required: false
      argument :due_date, String,
        required: false
    end

    def tasks(status: nil, priority: nil, due_date: nil)
      # Require authentication
      raise GraphQL::ExecutionError,
        "Unauthorized" unless context[:current_user]

      context[:current_user]
        .tasks
        .by_status(status)
        .by_priority(priority)
        .by_due_date(due_date)
        .order(created_at: :desc)
    end

    # Get single task
    field :task, Types::TaskType, null: true do
      argument :id, ID, required: true
    end

    def task(id:)
      raise GraphQL::ExecutionError,
        "Unauthorized" unless context[:current_user]

      context[:current_user]
        .tasks
        .find_by(id: id)
    end

    # Get current user
    field :me, Types::UserType, null: true

    def me
      context[:current_user]
    end
  end
end
