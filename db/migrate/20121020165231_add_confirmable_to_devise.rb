# WTF I had to write that one myself !
# Actually, c/p from http://stackoverflow.com/questions/4783392/how-do-i-enable-confirmable-in-devise
# But still ! WTF !?
class AddConfirmableToDevise < ActiveRecord::Migration
  def self.up
    add_column :gmf_component_users, :confirmation_token,    :string
    add_column :gmf_component_users, :confirmed_at,          :datetime
    add_column :gmf_component_users, :confirmation_sent_at , :datetime
    add_column :gmf_component_users, :unconfirmed_email,     :string

    add_index  :gmf_component_users, :confirmation_token,    :unique => true
  end
  def self.down
    remove_index  :gmf_component_users, :confirmation_token

    remove_column :gmf_component_users, :unconfirmed_email
    remove_column :gmf_component_users, :confirmation_sent_at
    remove_column :gmf_component_users, :confirmed_at
    remove_column :gmf_component_users, :confirmation_token
  end
end
