class AddConstraintsToColumnName < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :posts_counter :integer, null: false, default: 0
    # change_column :users, :posts_counter, "integer USING CAST(posts_counter AS integer)", null: false, default: 0
  end
end