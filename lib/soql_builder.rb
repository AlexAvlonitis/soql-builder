# frozen_string_literal: true

class SoqlBuilder
  TYPES = {
    select: 'select'
  }.freeze

  def initialize(type:)
    @query = []
    add_to_query(TYPES[type])
  end

  def query
    @query.clone.join(' ')
  end

  def fields(fields = [])
    add_to_query(structure_fields(fields))
    self
  end

  def add_child_lookup(child:, fields: [])
    subquery = ', (select '
    subquery += structure_fields(fields).join(' ')
    subquery += " from #{child})"
    add_to_query(subquery)
    self
  end

  def from(table)
    add_to_query('from ' + table)
    self
  end

  def where(query)
    add_to_query('where ' + query)
    self
  end

  private

  def add_to_query(partial_query)
    @query << partial_query
  end

  def structure_fields(fields)
    fields.map.with_index do |field, index|
      field << ',' unless fields.length - 1 == index
      field
    end
  end
end
