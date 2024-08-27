class AddUniqueIndexToSubmissions < ActiveRecord::Migration[6.0]
  def change
    add_index :submissions, [:email, :job_id], unique: true
  end
end
