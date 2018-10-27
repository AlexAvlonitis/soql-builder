# frozen_string_literal: true

class SoqlBuilder
  TYPES = {
    select: 'select'
  }.freeze

  def initialize(type:)
    @query = {
      type: TYPES[type],
      fields: [],
      subquery: {
        object_table: '',
        fields: []
      },
      object_table: '',
      where: '',
    }
  end

  def query
    structure_query
  end

  def fields(fields = [])
    @query[:fields] = fields
    self
  end

  def add_subquery(table:, fields: [])
    @query[:subquery][:object_table] = table
    @query[:subquery][:fields] = fields
    self
  end

  def from(table)
    @query[:object_table] = table
    self
  end

  def where(where_condition)
    @query[:where] = where_condition
    self
  end

  private

  def structure_query
    qs = @query[:type]
    qs += " #{structure_fields(@query[:fields])}" unless @query[:fields].empty?
    qs += ", (select #{ structure_fields(@query[:subquery][:fields]) } from #{ @query[:subquery][:object_table] })" unless @query[:subquery][:fields].empty?
    qs += " from #{@query[:object_table]}"
    qs += " where #{@query[:where]}" unless @query[:where] == ''
    qs
  end

  def structure_fields(fields)
    fields.map.with_index do |field, index|
      field << ',' unless fields.length - 1 == index
      field
    end.join(' ')
  end
end
