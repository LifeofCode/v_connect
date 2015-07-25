class AddAboutColumnToStudents < ActiveRecord::Migration
  def change
    add_column :students, :about, :text
  end
end
