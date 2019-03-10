# frozen_string_literal: true

require 'soql_builder/select_query'

module SoqlBuilder
  class Interface
    def initialize(type:)
      @query_klass = Module.const_get("SoqlBuilder::#{type.capitalize}Query")
      @query_params = {
        fields: [],
        subqueries: [],
        object_table: '',
        where: '',
        limit: ''
      }
    end

    def query
      @query_klass.structure_query(@query_params)
    end

    def clean
      @query_params[:fields] = []
      @query_params[:subqueries] = []
      @query_params[:object_table] = ''
      @query_params[:where] = ''
      @query_params[:limit] = ''
    end

    def fields(fields = [])
      @query_params[:fields] = fields
      self
    end

    def add_subquery(table:, fields: [])
      subquery = { object_table: table, fields: fields }
      @query_params[:subqueries] << subquery
      self
    end

    def from(table)
      @query_params[:object_table] = table
      self
    end

    def where(where_condition)
      @query_params[:where] = where_condition
      self
    end

    def limit(limit_number)
      @query_params[:limit] = limit_number.to_s
    end
  end
end