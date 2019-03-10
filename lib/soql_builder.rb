# frozen_string_literal: true

require 'soql_builder/interface'

module SoqlBuilder
  class << self
    def new(type:, query: nil)
      @interface = Interface.new(type: type, query: query)
    end

    attr_reader :interface
  end
end
