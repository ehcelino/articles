class AddTitleToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :title, :string
  end
end
