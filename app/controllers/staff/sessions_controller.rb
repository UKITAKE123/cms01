class Staff::SessionsController < Staff::Base

  def new
    if current_staff_member
      redirect_to :staff_root
    else
      @form = Staff::LoginForm.new
      render action: "new"
    end
  end

  def create
    @form = Staff::LoginForm.new(email: session_params[:email])
    if @form.email.present?
      staff_member =
        StaffMember.find_by(email: session_params[:email])
    end
    if Staff::Authenticator.new(staff_member).authenticate(session_params[:password])
      if staff_member.suspended?
        flash.now.alert = "アカウントが停止されています。"
        render action: "new"
      else
        session[:staff_member_id] = staff_member.id
        flash.notice = "ログインしました。"
        redirect_to :staff_root
      end
    else
      flash.now.alert = "メールアドレスまたはパスワードが正しくありません。"
      render action: "new"
    end
  end

  def destroy
    session.delete(:staff_member_id)
    flash.notice = "ログアウトしました。"
    redirect_to :staff_root
  end

  private

  def session_params
    params.require(:staff_login_form).permit(:email, :password)
  end
end
