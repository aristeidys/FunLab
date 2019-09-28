class CreateTaskResults < ActiveRecord::Migration[5.2]
  def change
    create_table :task_results do |t|
      t.boolean :completed
      t.boolean :succeeded
      t.decimal :numberOfGoodHelp
      t.decimal :numberOfBadHelp
    end
  end
end
