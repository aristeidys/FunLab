class CreateClassroomEnrollments < ActiveRecord::Migration[5.2]
  def change
    create_table :classroom_enrollments do |t|
      t.belongs_to :student
      t.belongs_to :classroom
    end
  end
end
