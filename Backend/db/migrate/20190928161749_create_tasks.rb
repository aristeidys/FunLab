class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.belongs_to :session
      t.string :name
      t.integer :difficulty
    end
  end
end
