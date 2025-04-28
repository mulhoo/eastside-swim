module Mutations
  class LogoutMutation < BaseMutation
    field :success, Boolean, null: false

    def resolve
      { success: true }
    end
  end
end
