class CreateUserStoryTasks < ActiveRecord::Migration
  def change
    create_table :user_story_tasks do |t|
      t.integer :user_story_id
      t.string :task_description

      t.timestamps
    end
  end
end
