require 'test_helper'

class ClassroomTest < ActiveSupport::TestCase

  test "save Classroom without name" do
    classroom = Classroom.new
    classroom.instructor_id = instructors(:sneip).id

    assert_not classroom.save, "Saved the classroom without a name"
  end

  test "save Classroom with small name" do
    classroom = validClassroom()
    classroom.name = "small"

    assert_not classroom.save, "Saved the classroom with small name"
  end

  test "save Classroom without instructor" do
    classroom = Classroom.new
    classroom.name = "smalligood"

    assert_not classroom.save, "Saved the classroom without instructor"
  end

  test "save Classroom successfully" do
    classroom = validClassroom()
    
    assert classroom.save, "Saved the classroom successfully"
  end

  test "save Classroom without unique name" do

    classroom = validClassroom()

    assert classroom.save

    classroom2 = validClassroom()


    assert_not classroom2.save, "Saved the classroom without unique name"
  end

  private
  def validClassroom
    classroom = Classroom.new
    classroom.name = "valid Name"
    classroom.instructor_id = instructors(:sneip).id
    classroom
  end
end