class CreateSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :skills do |t|
      t.string :slug
      t.string :label

      t.timestamps
    end
  end
end
