class Admin::SessionsController < Admin::Base

  def new
    if current_administrator
      redirect_to :admin_root
    else
      @form = Admin::LoginForm.new
      render action: "new"
    end
  end

  def create
    @form = Admin::LoginForm.new(email: session_params[:email])
    if @form.email.present?
      administrator =
        Administrator.find_by(email: session_params[:email])
    end
    if Admin::Authenticator.new(administrator).authenticate(session_params[:password])
      if administrator.suspended?
        flash.now.alert = "アカウントが停止されています。"
        render action: "new"
      else
        session[:administrator_id] = administrator.id
        flash.notice = "ログインしました。"
        redirect_to :admin_root
      end
    else
      flash.now.alert = "メールアドレスまたはパスワードが正しくありません。"
      render action: "new"
    end
  end

  def destroy
    session.delete(:administrator_id)
    flash.notice = "ログアウトしました。"
    redirect_to :admin_root
  end

  private

  def session_params
    params.require(:admin_login_form).permit(:email, :password)
  end
end
