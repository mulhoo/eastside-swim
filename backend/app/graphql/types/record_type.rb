# frozen_string_literal: true

module Types
  # Define common attributes used by our records
  module RecordType
    include Types::BaseInterface

    field :id, ID, null: false, description: 'The unique identifier of the resource.'
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
