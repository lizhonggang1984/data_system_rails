class AddAuthTokenToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :auth_token, :string
  end
end
