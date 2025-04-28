class CreatePayments < ActiveRecord::Migration[8.0]
  def change
    create_table :payments do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :athlete, foreign_key: true
      t.references :user, foreign_key: true
      t.string :payment_type, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.date :due_date, null: false
      t.date :paid_date
      t.boolean :paid, default: false
      t.string :payment_method
      t.text :notes

      t.timestamps
    end
  end
end
