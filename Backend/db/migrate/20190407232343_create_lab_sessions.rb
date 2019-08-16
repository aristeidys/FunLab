class CreateLabSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :lab_sessions do |t|
      t.string :title
      t.boolean :finished

      t.timestamps
    end
  end
end
