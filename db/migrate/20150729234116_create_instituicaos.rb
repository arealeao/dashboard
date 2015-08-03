class CreateInstituicaos < ActiveRecord::Migration
  def change
    create_table :instituicaos do |t|
      t.string :nome
      t.integer :idIlha
      t.string :omf
      t.string :vpn
      t.string :status

      t.timestamps null: false
    end
  end
end
