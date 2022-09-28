require_relative 'nameable'

class CapitalizeDecorator < Nameable
    def initialize(nameable)
      @nameable = nameable
    end
  
    def correct_name
      @nameable.correct_name.capitalize
    end
  end