require_relative 'person'
class Student < Person
  def initialize(age, classroom, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission)
    @classroom = classroom
    # add student to a classroom when setting classroom for a student
    classroom.add_student(self)
  end

  def play_hook
    "¯\(ツ)/¯"
  end
end
