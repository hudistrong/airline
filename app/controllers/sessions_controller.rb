class SessionsController < ApplicationController
  def create
    puts params
    @user = authenticate(params)
    if !verify_rucaptcha?(@user)
      redirect_to sign_in_path
      flash[:danger] = '验证码错误!'
    else
      sign_in(@user) do |status|
        if status.success?
          flash[:success] = '登陆成功!'
          redirect_to cities_path
        else
          flash[:danger] = '用户名或密码错误'
          render "sessions/new", status: :unauthorized
        end
      end
    end
  end

  def destroy
    sign_out
    redirect_to sign_in_path
  end
end