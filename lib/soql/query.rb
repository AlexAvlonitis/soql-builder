# frozen_string_literal: true

module Soql
  class Query
    attr_accessor :fields, :subquery, :object_table, :where, :limit
    attr_reader :type

    TYPES = {
      select: 'select'
    }.freeze

    def initialize
      @type = ''
      @fields = []
      @subquery = { object_table: '', fields: [] }
      @object_table = ''
      @where = ''
      @limit = ''
    end

    def type=(type)
      @type = TYPES[type]
    end

    def structure_query
      qs  = type
      qs += " #{join_fields(fields)}" unless fields.empty?
      qs += ", (select #{join_fields(subquery[:fields])} from #{subquery[:object_table]})" unless subquery[:fields].empty?
      qs += " from #{object_table}" unless object_table == ''
      qs += " where #{where}" unless where == ''
      qs += " limit #{limit}" unless limit == ''
      qs
    end

    def clean
      @fields = []
      @subquery = { object_table: '', fields: [] }
      @object_table = ''
      @where = ''
      @limit = ''
    end

    private

    def join_fields(fields)
      fields.join(', ')
    end
  end
end
