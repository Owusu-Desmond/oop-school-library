require_relative 'nameable'

class Person < Nameable
  attr_reader :name, :age, :id

  def initialize(age, name)
    super()
    @id = rand(100..999)
    @age = age
    @name = name
    @rentals = []
  end

  def correct_name
    @name
  end

  def add_rental(rental)
    @rentals << rental
  end
end
