class Staff::PasswordResetsController < ApplicationController
  before_filter :require_no_user
  before_filter :load_user_using_perishable_token, only: [:staff_edit, :staff_update]

  def staff_edit
    @path = staff_password_update_path
    render 'admin/password_resets/admin_edit'
  end

  def staff_update
    errors = []
    if @user
      @user.password_presence_validation = true
      @user.password = params[:password]
      @user.password_confirmation = params[:password_confirmation]
      @user.last_password_update_at = Time.now.utc
    end
    respond_to do |format|
      if @user.save
        if @user.first_login? && !@user.active?
          @user.activate(@user.default_hotel)
        end
        flash[:notice] = :thanks_youre_now_logged_in.l
        @user_session = UserSession.new(login:@user.email, password: params[:password])
        @user_session.save
        current_user = @user_session.record
        staff_redirect_path = @user.is_housekeeping_only ? staff_house_keeping_dashboard_url : staff_root_path
        format.html { redirect_to staff_redirect_path }
        format.json { render json: { status: 200, data: { access_token: pms_session.session_id, user: @user }, errors: '' } }
      else
        flash[:error] = @user.errors.full_messages.to_sentence
        format.html { render 'admin/password_resets/admin_edit' }
        format.json { render json: { status: 502, data: {}, errors: @user.errors.full_messages.to_sentence } }
      end
    end
  end

  private

  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    unless @user
      session[:activation_period_expired] = :activation_period_expired.l
      redirect_to staff_root_path
    end
  end
end
