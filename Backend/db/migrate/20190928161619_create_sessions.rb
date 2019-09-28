class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.belongs_to :module
      t.string :name
      t.boolean :isActive
    end
  end
end
