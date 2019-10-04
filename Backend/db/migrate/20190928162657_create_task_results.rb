class CreateTaskResults < ActiveRecord::Migration[5.2]
  def change
    create_table :task_results do |t|
      t.belongs_to :student
      t.belongs_to :task
      t.boolean :completed
      t.boolean :succeeded
      t.integer :numberOfGoodHelp
      t.integer :numberOfBadHelp
    end
  end
end
