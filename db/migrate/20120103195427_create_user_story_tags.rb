class CreateUserStoryTags < ActiveRecord::Migration
  def change
    create_table :user_story_tags do |t|
      t.integer :user_story_id
      t.string :tag_title

      t.timestamps
    end
  end
end
