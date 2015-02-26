class RemoveWrongActionStateFromMenuItems < ActiveRecord::Migration
  def change
    execute("UPDATE admin_menu_options set action_state = 'admin.message' where id in (select admin_menu_option_id from admin_menu_option_translations where name='Messages');")
    execute("UPDATE admin_menu_options set action_state = 'admin.myaccount' where id in (select admin_menu_option_id from admin_menu_option_translations where name='My Account');")
  end
end
