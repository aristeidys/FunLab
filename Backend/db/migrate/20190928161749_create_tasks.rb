class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.belongs_to :labsession
      t.string :name
      t.decimal :difficulty
    end
  end
end
