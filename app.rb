require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'
require_relative 'classroom'
require 'json'

class Data
  attr_accessor :books, :people, :rentals

  def initialize
    @books = File.open('store/books.json', 'r') do |file|
      JSON.parse(file.read)
    end
    @people = File.open('store/people.json', 'r') do |file|
      JSON.parse(file.read)
    end
    @rentals = File.open('store/rentals.json', 'r') do |file|
      JSON.parse(file.read)
    end
  end
end

class App
  attr_accessor :rentals, :books, :people, :classrooms

  def initialize
    # convert json data to ruby objects
    @books = Data.new.books.map { |book| Book.new(book['title'], book['author'], book['rentals']) }
    @people = Data.new.people.map do |peo|
      if peo.is_a?(Teacher)
        Teacher.new(peo['age'], peo['specialization'], peo['name'])
      else
        Student.new(peo['age'], peo['classroom'], peo['name'])
      end
    end
    @rentals = Data.new.rentals.each_with_index.map do |rental, index|
      Rental.new(rental['date'], @books[index], @people[index])
    end
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
      # display students
      puts '|_________________________All People_________________________|'
      @people.each do |person|
        puts "[Student] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" if person.is_a? Student
        puts "[Teacher] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" if person.is_a? Teacher
      end
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
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp.strip
    print 'Specialization: '
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

  def list_rentals_by_book_id
    puts 'Select a book from the following list by number'
    @books.each_with_index { |book, index| puts "#{index}) Title: #{book.title}, Author: #{book.author}" }
  end

  def list_rentals_for_person
    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def check_if_books_and_people_exist
    if @books.empty?
      puts 'No books found'
      return false
    elsif @people.empty?
      puts 'No people found'
      return false
    end
    true
  end

  def create_rental
    if check_if_books_and_people_exist
      begin
        list_rentals_by_book_id
        book_index = gets.chomp.to_i
        puts # empty line
        list_rentals_for_person
        person_index = gets.chomp.to_i
      rescue StandardError
        puts 'Invalid input, please try again'
        retry # retry the begin block
      end
      puts # empty line
      puts 'Input date e.g. 2021-01-01'
      print 'Date: '
      date = gets.chomp
      puts 'Sorry, You input invalid date' unless date.match?(/\d{4}-\d{2}-\d{2}/)
      @rentals << Rental.new(date, @books[book_index], @people[person_index])
      puts 'Rental created successfully'
    else
      puts 'Cannot create rental because there are no books or people in the app' end
  end

  def list_rentals_by_person_id
    puts # empty line
    print 'ID of person: '
    person_id = gets.chomp.to_i

    is_id_exist = @people.any? { |person| person.id == person_id }
    if is_id_exist
      puts # empty line
      puts "|____________All rentals of person(id: #{person_id})____________|"
      @rentals.each do |rental|
        if rental.person.id == person_id
          puts "Date: #{rental.date}, Book: #{rental.book.title} by #{rental.book.author}"
        end
      end
    else
      puts 'ID not found'
    end
  end
end
