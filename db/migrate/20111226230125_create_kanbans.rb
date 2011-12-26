class CreateKanbans < ActiveRecord::Migration
  def change
    create_table :kanbans do |t|
      t.string :title

      t.timestamps
    end
  end
end
