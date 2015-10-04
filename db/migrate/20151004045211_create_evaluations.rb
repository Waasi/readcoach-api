class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.integer :words_read
      t.integer :total_words
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
