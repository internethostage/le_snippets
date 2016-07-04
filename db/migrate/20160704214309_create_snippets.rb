class CreateSnippets < ActiveRecord::Migration[5.0]
  def change
    create_table :snippets do |t|
      t.string :name
      t.text :body
      t.boolean :private, default: false
      t.references :user, foreign_key: true, index: true
      t.references :language, foreign_key: true, index: true

      t.timestamps
    end
  end
end
