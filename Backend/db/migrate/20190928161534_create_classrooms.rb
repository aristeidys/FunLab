class CreateClassrooms < ActiveRecord::Migration[5.2]
  def change
    create_table :classrooms do |t|
      t.belongs_to :instructor
      t.string :name
    end
  end
end
