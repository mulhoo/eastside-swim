# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # Users
    field :login, mutation: Mutations::LoginMutation
    field :signup, mutation: Mutations::SignupMutation
    field :logout, mutation: Mutations::LogoutMutation

    # Organizations

    # Practice Groups

    # Practice Times

    # Athletes

    # Events

    # Event Entries

    # Payments

    # Relay Team

    # Relay Team Athletes

    # Tryouts

    # Sports

    # Facilities



  end
end
