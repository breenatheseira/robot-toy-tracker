class ChangeDataTypeForPosition < ActiveRecord::Migration
  def change
  	change_column :robots, :position, :integers
  end
end
