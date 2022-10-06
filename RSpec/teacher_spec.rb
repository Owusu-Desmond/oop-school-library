require_relative '../teacher'

describe Teacher do
  let(:teacher) { Teacher.new(30, 'Math', 'John') }

  describe '#new' do
    it 'creates a new teacher' do
      expect(teacher).to be_a(Teacher)
    end

    it 'has a name' do
      expect(teacher.name).to eq('John')
    end

    it 'has an age' do
      expect(teacher.age).to eq(30)
    end

    it 'has a specialization' do
      expect(teacher.specialization).to eq('Math')
    end
  end
end
