class CreateInstructors < ActiveRecord::Migration[5.2]
  def change
    create_table :instructors do |t|
      t.has_many :modules
      t.string :name
      t.string :username
      t.string :password
    end
  end
end
