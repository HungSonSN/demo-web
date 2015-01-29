class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.references :entry, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :comments, :entries
    add_foreign_key :comments, :users
  end
end
