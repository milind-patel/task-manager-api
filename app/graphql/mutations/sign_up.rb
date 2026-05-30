module Mutations
  class SignUp < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    type Types::AuthType

    def resolve(email:, password:)
      user = User.new(
        email: email,
        password: password
      )

      if user.save
        token = Warden::JWTAuth::UserEncoder.new.call(
          user, :user, nil
        ).first

        { token: token, user: user }
      else
        raise GraphQL::ExecutionError,
          user.errors.full_messages.join(", ")
      end
    end
  end
end
