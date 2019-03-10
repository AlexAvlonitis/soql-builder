# frozen_string_literal: true

require 'soql_builder/interface'

module SoqlBuilder
  class << self
    def new(type:)
      @interface = Interface.new(type: type)
    end

    attr_reader :interface
  end
end
