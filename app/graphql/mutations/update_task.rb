module Mutations
  class UpdateTask < BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: false
    argument :description, String, required: false
    argument :status, Types::TaskStatusEnum,
      required: false
    argument :priority, Types::TaskPriorityEnum,
      required: false
    argument :due_date, String, required: false

    type Types::TaskType

    def resolve(id:, **attrs)
      raise GraphQL::ExecutionError,
        "Unauthorized" unless context[:current_user]

      task = context[:current_user]
        .tasks
        .find_by(id: id)

      raise GraphQL::ExecutionError,
        "Task not found" unless task

      if task.update(attrs.compact)
        task
      else
        raise GraphQL::ExecutionError,
          task.errors.full_messages.join(", ")
      end
    end
  end
end
