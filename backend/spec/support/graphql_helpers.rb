# frozen_string_literal: true

module GraphQLHelpers
  def execute_query(query, variables: nil, context: {})
    # Wrap with `Bullet.profile do..end` to profile for N+1 queries.
    # Violations will be logged to log/bullet.log

    BizzyBackendSchema.execute(query, variables: variables, context: context).as_json
  end

  # Mutations/Queries
  MUTATION_REGEX = /\A(?<name>\S*)_mutation\z/.freeze
  QUERY_REGEX = /\A(?<name>\S*)_query\z/.freeze

  def method_missing(method_name, *args, &block)
    if (mutation = method_name.match(MUTATION_REGEX))
      read_mutation mutation[:name]
    elsif (query = method_name.match(QUERY_REGEX))
      read_query query[:name]
    else
      super
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    method_name.match(MUTATION_REGEX) || method_name.match(QUERY_REGEX) || super
  end

  def read_mutation(filename)
    file_fixture("graphql/mutations/#{filename}.gql").read
  end

  def read_query(filename)
    file_fixture("graphql/queries/#{filename}.gql").read
  end
end
