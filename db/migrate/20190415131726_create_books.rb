class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :Call_num
      t.string :Title
      t.string :Subtitle
      t.string :Author_first
      t.string :Author_Last
      t.integer :Copyright
      t.text :Subject
      t.text :Annotation
      t.boolean :status

      t.timestamps
    end
  end
end
