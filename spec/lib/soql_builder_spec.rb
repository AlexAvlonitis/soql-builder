require 'spec_helper'
require 'soql_builder'
require 'soql/query'

describe SoqlBuilder do
  let(:query) { Soql::Query.new }
  let(:subject) { described_class.new(type: :select, query: query) }

  describe 'Build a simple soql query' do
    context 'When you construct the object with select/from/where' do
      it 'returns a correct soql query' do
        subject.fields(['Name', 'Contract__r.Name'])
               .from('Account')
               .where('id = 1')

        expect(subject.query)
          .to eq 'select Name, Contract__r.Name from Account where id = 1'
      end
    end

    context 'When you construct the object with select/from/where and limit' do
      it 'returns a correct soql query' do
        subject.fields(['Name', 'Contract__r.Name'])
               .from('Account')
               .where('id = 1')
               .limit(1)

        expect(subject.query)
          .to eq 'select Name, Contract__r.Name from Account where id = 1 limit 1'
      end
    end

    context 'When you construct the object with select/from without where' do
      it 'returns a correct soql query' do
        subject.fields(['Name', 'Contract__r.Name'])
               .from('Account')

        expect(subject.query)
          .to eq 'select Name, Contract__r.Name from Account'
      end
    end

    context 'When we want to have a parent lookup' do
      it 'return a correct soql query' do
        subject.fields(['Name', 'Contract__r.Name'])
               .add_subquery(
                 table: 'Account.quotes', fields: ['quotes.name', 'quotes.Custom__c']
               )
               .from('Account')

        expect(subject.query)
          .to eq 'select Name, Contract__r.Name, (select quotes.name, quotes.Custom__c from Account.quotes) from Account'
      end
    end

    context 'When you submit the query two times' do
      it 'does not alter the query string' do
        subject.fields(['Name', 'Contract__r.Name'])
               .add_subquery(
                 table: 'Account.quotes', fields: ['quotes.name', 'quotes.Custom__c']
               )
               .from('Account')

        subject.query
        expect(subject.query)
          .to eq 'select Name, Contract__r.Name, (select quotes.name, quotes.Custom__c from Account.quotes) from Account'
      end
    end

    context 'When you want to recreate a query without having to create another object' do
      it 'resets the query' do
        subject.fields(['Name', 'Contract__r.Name'])
               .add_subquery(
                 table: 'Account.quotes', fields: ['quotes.name', 'quotes.Custom__c']
               )
               .from('Account')

        subject.clean
        expect(subject.query).to eq 'select'
      end
    end
  end
end
