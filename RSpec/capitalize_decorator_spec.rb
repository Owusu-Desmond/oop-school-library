require_relative '../capitalize_decorator'
require_relative '../person'

describe CapitalizeDecorator do
  person = Person.new(18, 'desmond@Code360')
  capitalize = CapitalizeDecorator.new(person)

  describe '#correct_name' do
    it 'returns the first 10 characters of the name' do
      expect(capitalize.correct_name).to eq('Desmond@code360')
    end
  end
end
