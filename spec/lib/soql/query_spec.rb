require 'spec_helper'
require 'soql/query'

describe Soql::Query do
  let(:query) { described_class.new }

  it { is_expected.to respond_to(:fields) }
  it { is_expected.to respond_to(:subquery) }
  it { is_expected.to respond_to(:object_table) }
  it { is_expected.to respond_to(:type) }
  it { is_expected.to respond_to(:where) }
  it { is_expected.to respond_to(:limit) }

  describe '#structure_query' do
    context 'When all objects are filled' do
      it 'returns a structured query string' do
        subject.type = :select
        subject.fields = ['Name']
        subject.object_table = 'Account'

        expect(subject.structure_query).to eq('select Name from Account')
      end
    end
  end
end
