class AddAttributesToRobots < ActiveRecord::Migration
  def change
    add_column :robots, :name, :string
    add_column :robots, :x_coordinate, :integer
    add_column :robots, :y_coordinate, :integer
    add_column :robots, :position, :string
  end
end
