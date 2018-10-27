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
    fields_string = fields.map.with_index do |field, index|
      field << ',' unless fields.length - 1 == index
      field
    end
    add_to_query(fields_string)
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
end
