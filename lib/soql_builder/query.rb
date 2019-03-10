# frozen_string_literal: true

module SoqlBuilder
  class Query
    TYPES = {
      select: 'select'
    }.freeze

    def initialize
      @query = ''
    end

    def structure_query(args = {})
      @query  = TYPES[args[:type]]
      @query += " #{join_fields(args[:fields])}" unless args[:fields].empty?
      @query += join_subqueries(args[:subqueries]) unless args[:subqueries].empty?
      @query += " from #{args[:object_table]}" unless args[:object_table] == ''
      @query += " where #{args[:where]}" unless args[:where] == ''
      @query += " limit #{args[:limit]}" unless args[:limit] == ''
      @query
    end

    private

    def join_fields(fields)
      fields.join(', ')
    end

    def join_subqueries(subqueries)
      subqueries.map do |subquery|
        ", (select #{join_fields(subquery[:fields])} from #{subquery[:object_table]})"
      end.join
    end
  end
end
