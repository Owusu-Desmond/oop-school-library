class Rental
  attr_accessor :date, :book, :person

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
    # Add the rental to the book and person
    puts @book
    puts @person
    @book.add_rental(self)
    @person.add_rental(self)
  end
end
