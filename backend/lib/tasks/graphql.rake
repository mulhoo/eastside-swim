require "graphql/rake_task"

namespace :graphql do
  desc "Dump GraphQL schema"

  task :schema_dump => :environment do
    GraphQL::RakeTask.new do |task|
      task.schema_name = "KeepUpSchema"
      task.json_outfile = "schema.json"
      task.idl_outfile = "schema.graphql"
    end

    Rake::Task["graphql:schema:dump"].invoke
  end
end
