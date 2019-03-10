# frozen_string_literal: true

require 'soql_builder/query'

module SoqlBuilder
  class Interface
    def initialize(type:, query: nil)
      @query = query || SoqlBuilder::Query.new
      @type = type
      @fields = []
      @subqueries = []
      @subquery = { object_table: '', fields: [] }
      @object_table = ''
      @where = ''
      @limit = ''
    end

    def query
      @query.structure_query(
        type: @type,
        fields: @fields,
        subqueries: @subqueries,
        object_table: @object_table,
        where: @where,
        limit: @limit
      )
    end

    def clean
      @fields = []
      @subqueries = []
      @object_table = ''
      @where = ''
      @limit = ''
    end

    def fields(fields = [])
      @fields = fields
      self
    end

    def add_subquery(table:, fields: [])
      @subquery = { object_table: table, fields: fields }
      @subqueries << @subquery
      self
    end

    def from(table)
      @object_table = table
      self
    end

    def where(where_condition)
      @where = where_condition
      self
    end

    def limit(limit_number)
      @limit = limit_number.to_s
    end
  end
end