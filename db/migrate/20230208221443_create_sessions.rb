class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :login_at
      t.datetime :logout_at

      t.timestamps
    end
  end
end
