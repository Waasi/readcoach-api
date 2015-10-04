class AddPhraseCountEval < ActiveRecord::Migration
  def change
    add_column :evaluations, :phrase_read, :integer
  end
end
