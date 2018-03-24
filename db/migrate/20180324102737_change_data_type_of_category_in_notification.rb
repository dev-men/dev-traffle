class ChangeDataTypeOfCategoryInNotification < ActiveRecord::Migration[5.1]
  def up
    change_column :notifications, :category, :integer
  end
  def down
    change_column :notifications, :category, :string
  end
end
