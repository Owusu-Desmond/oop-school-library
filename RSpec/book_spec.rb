require_relative '../book'

describe Book do
  let(:book) { Book.new('The Alchemist', 'Paulo Coelho') }

  describe '#new' do
    it 'creates a new book' do
      expect(book).to be_a(Book) # book is an instance of the Book class
    end

    it 'has a title' do
      expect(book.title).to eq('The Alchemist')
    end

    it 'has an author' do
      expect(book.author).to eq('Paulo Coelho')
    end

    it 'has no rentals' do
      expect(book.rentals).to be_empty
    end
  end
end
