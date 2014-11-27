class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :provider
      t.string :user_id
      t.string :name

      t.timestamps
    end
  end
end
