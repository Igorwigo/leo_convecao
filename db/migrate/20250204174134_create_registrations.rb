class CreateRegistrations < ActiveRecord::Migration[7.1]
  def change
    create_table :registrations do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.string :status, null: false, default: 'pending'
      t.text :obs
      t.text :message,default: 'Inscrição pendente, realize o pagamento. Nao fique de fora dessa!'
      t.string :club
      t.string :qrcode

      t.timestamps
    end
    add_index :registrations, :email, unique: true
  end
end
