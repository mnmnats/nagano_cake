class CreateGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :genres do |t|
      belongs_to :genre

      t.timestamps
      t.string :name, null: false
    end
  end
end
