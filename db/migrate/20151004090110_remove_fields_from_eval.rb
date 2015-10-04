class RemoveFieldsFromEval < ActiveRecord::Migration
  def change
    remove_column :evaluations, :total_words
  end
end
