class AddDateToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :date, :string
  end
end
