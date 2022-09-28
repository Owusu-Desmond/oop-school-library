require_relative 'nameable'

class Person < Nameable
  attr_reader :name, :age

  def initialize(age, name)
    @age = age
    @name = name
  end

  def correct_name
    @name
  end
end