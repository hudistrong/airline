class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
    @user = user_from_params
    user = User.where(email: @user.email).first
    if @user.save
      flash[:success] = '注册成功!'
      sign_in @user
      redirect_to cities_path
    else
      if user.present?
        flash[:danger] = "该邮箱已被使用!"
      elsif @user.password.blank? || @user.email.blank?
        flash[:danger] = "邮箱或密码不能为空!"
      else
        flash[:danger] = "注册失败!"
      end
      
      render template: "users/new"
    end
  end

  def edit_password
  end

  def update_password
    @user = User.authenticate(current_user.email,params[:password])
    if @user.present?
      @user.password = params[:new_password]
      if @user.save
        flash[:success] = '保存成功!'
        redirect_to cities_path
      else
        render :edit_password
      end
    elsif params[:password].blank? || params[:new_password].blank?
      flash[:danger] = '密码不能为空!'
      render :edit_password
    else
      flash[:danger] = '原密码错误!'
      render :edit_password
    end
  end

  private

	  def user_from_params
	    email = user_params.delete(:email)
	    password = user_params.delete(:password)

	    Clearance.configuration.user_model.new(user_params).tap do |user|
	      user.email = email
	      user.password = password
	    end
	  end

	  def user_params
	    params[Clearance.configuration.user_parameter] || Hash.new
	  end
end