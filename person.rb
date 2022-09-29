require_relative 'nameable'

class Person < Nameable
  attr_reader :name, :age

  def initialize(age, name)
    super()
    @age = age
    @name = name
    @rental = []
  end

  def correct_name
    @name
  end

  def add_rental(rental)
    @rental << rental
  end
end
