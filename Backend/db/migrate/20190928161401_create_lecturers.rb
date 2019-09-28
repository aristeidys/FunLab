class CreateLecturers < ActiveRecord::Migration[5.2]
  def change
    create_table :lecturers do |t|
      t.string :name
      t.string :username
      t.string :password
    end
  end
end
