class AddNamesAndMoneyToCustomer < ActiveRecord::Migration[5.2]
  def change

    add_column :customers, :first_name, :string, :null => false;
    add_column :customers, :last_name, :string, :null => false;
    add_column :customers, :money, :decimal, :precision => 10, :scale => 2, :default => 0.0, :null => false

  end
end
