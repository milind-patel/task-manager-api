module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :tasks, [ Types::TaskType ], null: false
  end
end
