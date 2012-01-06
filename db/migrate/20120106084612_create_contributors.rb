class CreateContributors < ActiveRecord::Migration
  def change
    create_table :contributors do |t|
      t.integer :project_id
      t.integer :user_id
      t.datetime :created_at

      t.timestamps
    end
  end
end
