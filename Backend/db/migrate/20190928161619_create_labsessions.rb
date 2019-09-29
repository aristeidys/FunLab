class CreateLabsessions < ActiveRecord::Migration[5.2]
  def change
    create_table :labsessions do |t|
      t.belongs_to :classroom
      t.string :name
      t.boolean :isActive
    end
  end
end
