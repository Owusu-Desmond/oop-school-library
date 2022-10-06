require_relative '../rental'
require_relative '../book'
require_relative '../person'

describe Rental do
  let(:book) { Book.new('The Hobbit', 'J.R.R. Tolkien') }
  let(:person) { Person.new('John Doe', 20) }
  let(:rental) { Rental.new('2020-01-01', book, person) }

  describe '#new' do
    it 'creates a new rental' do
      expect(rental).to be_a(Rental)
    end

    it 'has a date' do
      expect(rental.date).to eq('2020-01-01')
    end

    it 'has a book' do
      expect(rental.book).to eq(book)
    end

    it 'has a person' do
      expect(rental.person).to eq(person)
    end

    it 'adds the rental to the book' do
      expect(book.rentals).to include(rental)
    end
  end
end
