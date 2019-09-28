class CreateModules < ActiveRecord::Migration[5.2]
  def change
    create_table :modules do |t|
      t.string :name
    end
  end
end
