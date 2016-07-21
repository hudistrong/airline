class SessionsController < ApplicationController
  def create
    @user = authenticate(params)
    sign_in(@user) do |status|
      if status.success?
        flash[:success] = '登陆成功!'
        redirect_to cities_path
      else
        flash[:danger] = '用户名或密码错误'
        render template: "sessions/new", status: :unauthorized
      end
    end
  end

  def destroy
    sign_out
    redirect_to sign_in_path
  end
end