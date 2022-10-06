require_relative '../person'
describe Person do
  let(:person) { Person.new(20, 'John' ) } 

  describe '#new' do
    it 'creates a new person' do
      expect(person).to be_a(Person)
    end

    it 'has a name' do
      expect(person.name).to eq('John')
    end

    it 'has an age' do
      expect(person.age).to eq(20)
    end
  end
end
