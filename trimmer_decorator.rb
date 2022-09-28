require_relative 'nameable'

class TrimmerDecorator < Nameable
  def initialize(nameable)
    super()
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name[0..9]
  end
end
