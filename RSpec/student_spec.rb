require_relative '../student'

describe Student do
  # the let method is used to create a variable that can be used in the tests
  let(:student) do
    Student.new(18, 'Classroom A', 'John')
  end
  describe '#new' do
    it 'creates a new student' do
      expect(student).to be_a(Student)
    end

    it 'has a name' do
      expect(student.name).to eq('John')
    end

    it 'has an age' do
      expect(student.age).to eq(18)
    end

    it 'has a classroom' do
      expect(student.classroom).to eq('Classroom A')
    end
  end
end
