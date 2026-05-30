module Mutations
  class CreateTask < BaseMutation
    argument :title, String, required: true
    argument :description, String, required: false
    argument :status, Types::TaskStatusEnum,
      required: false
    argument :priority, Types::TaskPriorityEnum,
      required: false
    argument :due_date, String, required: false

    type Types::TaskType

    def resolve(title:, description: nil,
      status: "pending", priority: "medium",
      due_date: nil)
      raise GraphQL::ExecutionError,
        "Unauthorized" unless context[:current_user]

      task = context[:current_user].tasks.build(
        title: title,
        description: description,
        status: status,
        priority: priority,
        due_date: due_date
      )

      if task.save
        task
      else
        raise GraphQL::ExecutionError,
          task.errors.full_messages.join(", ")
      end
    end
  end
end
