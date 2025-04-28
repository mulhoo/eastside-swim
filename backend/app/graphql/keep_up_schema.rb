# frozen_string_literal: true

class KeepUpSchema < GraphQL::Schema
  query(Types::QueryType)
  mutation(Types::MutationType)

  use GraphQL::Dataloader
  # use GraphQL::Execution::Interpreter
  # use GraphQL::Analysis::AST

  def self.type_error(err, context)
    super
  end

  def self.resolve_type(abstract_type, obj, ctx)
    raise(GraphQL::RequiredImplementationMissingError)
  end

  max_query_string_tokens(5000)
  validate_max_errors(100)

  def self.id_from_object(object, type_definition, query_ctx)
    object.to_gid_param
  end

  def self.object_from_id(global_id, query_ctx)
    GlobalID.find(global_id)
  end

  def self.to_definition_path
    Rails.root.join("schema.graphql")
  end

  def self.to_json_path
    Rails.root.join("schema.json")
  end
end
