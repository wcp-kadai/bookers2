class ChangeColumnsToBooks < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :opinion, :text
    add_column :books, :body, :text
  end
end
