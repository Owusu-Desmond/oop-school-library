class Person 
    attr_accessor :name, :age
    attr_reader :id
    def initialize(age, name = "Unknown", parent_permission: true)
        @id = Ramdom.rand(0 .. 1000)
        @age = age
        @name = name
        @parent_permission = parent_permission
    end

    def can_use_services?
        is_of_age? || parent_permission
    def

    private 
    def is_of_age?
        @age >= 18
    end
end

class Student < Person
    def initialize(age, classroom, name = "Unknown", parent_permission: true)
        super(age, name, parent_permission)
        @classroom = classroom
    end

    def play_hook
        "¯\(ツ)/¯"
    end
end

class Teacher < Person
    def initialize(age, specialization, name = "Unknown", parent_permission: true)
        super(age, name, parent_permission)
        @specialization = specialization
    end

    def can_use_services?
        true
    end
end