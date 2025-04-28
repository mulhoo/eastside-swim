# app/graphql/mutations/signup_user.rb
module Mutations
  class SignupMutation < Mutations::BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true
    argument :first_name, String, required: true
    argument :last_name, String, required: true

    field :token, String, null: true
    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(email:, password:, first_name:, last_name:)
      user = User.new(
        email: email,
        password: password,
        first_name: first_name,
        last_name: last_name
      )

      if user.save
        token = JsonWebToken.encode(user_id: user.id)

        {
          user: user,
          token: token,
          errors: []
        }
      else
        {
          user: nil,
          token: nil,
          errors: user.errors.full_messages
        }
      end
    end
  end
end
