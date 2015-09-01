class CreateTasklets < ActiveRecord::Migration
  def change
    create_table :tasklets do |t|
      t.integer :task_id
      t.integer :subtask_id

      t.timestamps null: false
    end
  end
end
