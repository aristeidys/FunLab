require 'test_helper'

class ClassroomTest < ActiveSupport::TestCase

  # Instantiation

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

  # Search

  test "find Classroom by name" do

    classroomFound = Classroom.findByName("The best classroom").first

    assert_not_nil classroomFound, "Didn't find classroom by name"
  end

  test "find Classroom by nonexisting name" do

    classroomFound = Classroom.findByName("not existing name").first

    assert_nil classroomFound, "Found unknown classroom by name"
  end

  test "find Classroom by instructor_id" do

    validClassroom().save

    classroomFound = Classroom.findByParentID(1).first

    assert_not_nil classroomFound, "Didn't find classroom by instructor_id"
  end

  test "find Classroom by nonexisting instructor_id" do

    validClassroom().save

    classroomFound = Classroom.findByParentID(14234).first

    assert_nil classroomFound, "Found classroom by invalid instructor_id"
  end

  private

  def validClassroom
    classroom = Classroom.new
    classroom.name = "valid Name"
    classroom.instructor_id = instructors(:sneip).id
    classroom
  end
end