# frozen_string_literal: true

require 'soql/query'

class SoqlBuilder
  def initialize(type:, query: nil)
    @query = query || Soql::Query.new
    @query.type = type
  end

  def query
    @query.structure_query
  end

  def clean
    @query.clean
  end

  def fields(fields = [])
    @query.fields = fields
    self
  end

  def add_subquery(table:, fields: [])
    @query.subquery[:object_table] = table
    @query.subquery[:fields] = fields
    self
  end

  def from(table)
    @query.object_table = table
    self
  end

  def where(where_condition)
    @query.where = where_condition
    self
  end

  def limit(limit_number)
    @query.limit = limit_number.to_s
  end
end
