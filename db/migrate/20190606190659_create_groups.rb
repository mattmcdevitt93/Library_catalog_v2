class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :Name
      t.boolean :is_admin
      t.boolean :is_approver

      t.timestamps
    end
  end
end
