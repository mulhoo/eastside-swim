class Resolvers::UserResolver < BaseResolver
  type Types::UserType, null: true

  argument :id, ID, required: true

  def resolve(id:)
    user = User.find(id)
    authorize!(user, :show?)
    user
  end
end
