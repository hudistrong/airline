class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
    @user = user_from_params
    user = User.where(email: @user.email).first
    if @user.username.blank?
      flash[:danger] = "用户名不能为空"
      render :new
    else
      if @user.save
        #裁减头像
        @user.shave_avatar
        flash[:success] = '注册成功!'
        sign_in @user
        @user.add_role :visitor
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

  def avatar_upload
  end

  def upload_avatar
    current_user.avatar = user_from_params.avatar
    if current_user.save
      current_user.shave_avatar
      flash[:success] = "修改成功!"
    else
      flash[:danger] = "修改失败!"
    end
    redirect_to cities_path
  end

  private

	  def user_from_params
      username = user_params.delete(:username)
	    email = user_params.delete(:email)
	    password = user_params.delete(:password)
      avatar = user_params.delete(:avatar)

	    Clearance.configuration.user_model.new(user_params).tap do |user|
	      user.username = username
        user.email = email
	      user.password = password
        user.avatar = avatar
	    end
	  end

	  def user_params
	    params[Clearance.configuration.user_parameter] || Hash.new
	  end
end