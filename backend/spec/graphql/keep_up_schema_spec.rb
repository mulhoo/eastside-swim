require 'rails_helper'

RSpec.describe KeepUpSchema do
  it 'matches the dumped schema (rails graphql:schema_dump)' do
    aggregate_failures do
      expect(described_class.to_definition.chomp).to eq(File.read(Rails.root.join('schema.graphql')).rstrip)
      expect(described_class.to_json).to eq(File.read(Rails.root.join('schema.json')).rstrip)
    end
  end
end
