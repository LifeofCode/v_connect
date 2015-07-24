class ChangePostsToOpportunities < ActiveRecord::Migration
  def change
    rename_table :posts, :opportunities
  end
end
