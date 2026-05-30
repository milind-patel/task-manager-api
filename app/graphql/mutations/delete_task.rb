module Mutations
  class DeleteTask < BaseMutation
    argument :id, ID, required: true

    type Boolean

    def resolve(id:)
      raise GraphQL::ExecutionError,
        "Unauthorized" unless context[:current_user]

      task = context[:current_user]
        .tasks
        .find_by(id: id)

      raise GraphQL::ExecutionError,
        "Task not found" unless task

      task.destroy
      true
    end
  end
end
