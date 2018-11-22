require 'spec_helper'
require 'soql/query'

describe Soql::Query do
  let(:query) { described_class.new }

  let(:type) { :select }
  let(:fields) { ['Name'] }
  let(:object_table) { 'Account' }
  let(:subqueries) { [] }
  let(:where) { '' }
  let(:limit) { '' }

  describe '#structure_query' do
    context 'When all objects are filled' do
      it 'returns a structured query string' do
        expect(subject.structure_query(
          type: type,
          fields: fields,
          subqueries: subqueries,
          object_table: object_table,
          where: where,
          limit: limit
        )).to eq('select Name from Account')
      end
    end
  end
end
