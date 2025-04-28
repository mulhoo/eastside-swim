# app/graphql/mutations/login_user.rb

module Mutations
  class LoginMutation < Mutations::BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: true
    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(email:, password:)
      user = User.find_by(email: email)

      if user&.authenticate(password)
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
          errors: ["Invalid email or password"]
        }
      end
    end
  end
end
