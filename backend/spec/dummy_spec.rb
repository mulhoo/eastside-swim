# spec/models/dummy_spec.rb
require 'rails_helper'

class Dummy
  include ActiveModel::Model
end

RSpec.describe Dummy, type: :model do
  it 'works' do
    expect(true).to eq(true)
  end
end
