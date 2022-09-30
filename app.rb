require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'
require_relative 'classroom'

class App
  attr_accessor :rentals, :books, :people, :classrooms

  def initialize
    @rentals = []
    @books = []
    @people = []
    @classrooms = []
  end

  def list_books
    if @books.empty?
      puts 'No books found'
    else
      puts '|_________________________All books:_________________________|'
      @books.each { |book| puts "| Title: #{book.title}, Author: #{book.author}" }
    end
  end

  def list_people
    if @people.empty?
      puts 'No people found'
    else
      puts '|_________________________All people:_________________________|'
      @people.each { |person| puts "| Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" }
    end
  end

  def create_student
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Has parent permission? [Y/N]: '
    parent_permission = gets.chomp.downcase == 'y'
    print 'Classroom: '
    classroom = gets.chomp
    @people << Student.new(age, classroom, name, parent_permission: parent_permission)
    puts 'Person created successfully'
  end

  def create_teacher
    puts 'Age: '
    age = gets.chomp.to_i
    puts 'Name: '
    name = gets.chomp.strip
    puts 'Specialization: '
    specialization = gets.chomp.strip
    @people << Teacher.new(age, specialization, name)
    puts 'Teacher created successfully'
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]:'
    person_type = gets.chomp.to_i
    # if person type is not 1 or 2, display error message and call create_person method again
    case person_type
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Sorry, You input invalid option'
      create_person
    end
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    @books << Book.new(title, author)
    puts 'Book created successfully'
  end

  def create_rental
    print 'ID of person: '
    person_id = gets.chomp.to_i
    print 'Title of book: '
    book_title = gets.chomp
    puts 'Input date e.g. 2021-01-01'
    print 'Date: '
    date = gets.chomp.match?(/\d{4}-\d{2}-\d{2}/)
    unless date
      puts 'Sorry, You input invalid date'
      create_rental
      return
    end
    book = @books.find { |b| b.title == book_title }
    person = @people.find { |psn| psn.id == person_id }
    if book && person
      @rentals << Rental.new(date, book, person)
      puts 'Rental created successfully'
    else
      puts 'Sorry, ID or Title not found'
    end
  end

  def list_rentals_by_person_id
    print 'ID of person: '
    person_id = gets.chomp.to_i
    puts '|_________________________Rentals:_________________________|'
    @rentals.each do |rental|
      if rental.person.id == person_id
        puts "Date: #{rental.date}, Book: #{rental.book.title} by #{rental.book.author}"
      else
        puts 'No rentals found'
      end
    end
  end
end
