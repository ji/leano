class CreateUserStories < ActiveRecord::Migration
  def change
    create_table :user_stories do |t|
      t.integer :kanban_id
      t.string :title
      t.string :description
      t.string :color
      t.integer :assignee
      t.string :priority
      t.boolean :blocked

      t.timestamps
    end
  end
end
