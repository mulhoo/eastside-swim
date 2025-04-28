Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"

  get "static/index"

  namespace :api do
    # Define your API routes here
  end

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql", as: :graphiql,
      graphql_headers: -> (context) {
        {
          "Authorization" => "Bearer your_example_token"
        }
      },
      title: "Eastside Swim GraphQL IDE",
      initial_query: <<-GRAPHQL
        query {
          __schema {
            types {
              name
            }
          }
        }
      GRAPHQL
    root to: redirect('/graphiql')
  else
    root to: proc { [200, {}, ['API is running']] }
  end

  # React fallback route (catch-all)
  get '*path', to: 'static#index', constraints: ->(req) { !req.xhr? && req.format.html? }

  get "up" => "rails/health#show", as: :rails_health_check
end
