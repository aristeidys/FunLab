class CreateTaskResults < ActiveRecord::Migration[5.2]
  def change
    create_table :task_results do |t|
      t.belongs_to :student
      t.belongs_to :task
      t.string :task_name
      t.boolean :completed
      t.boolean :locked
      t.integer :numberOfGoodHelp
      t.integer :numberOfBadHelp
    end
  end
end
