class CreateStudentSessionAssociation < ActiveRecord::Migration[5.2]
  def change
    create_table :enrolments do |t|
      t.belongs_to :lab_session
      t.belongs_to :student

      t.timestamps
    end
  end
end
