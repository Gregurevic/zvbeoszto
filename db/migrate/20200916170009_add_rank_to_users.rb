class AddRankToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :rank, :string
    add_column :users, :rank_id, :integer
  end
end
