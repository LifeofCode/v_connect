class AddFavCounter < ActiveRecord::Migration
  def change
    add_column :organizations, :favourites_count, :integer, :default => 0

    Organization.reset_column_information

    Organization.all.each do |p|
      Organization.update_counters p.id, favourites_count: p.favourites.length
    end

  end
end
