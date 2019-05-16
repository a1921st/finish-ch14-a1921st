class UsersController < ApplicationController
  #GET /users/:id
  def show
    @user = User.find(params[:id])
    # =>  app/views/users/show.html.erb
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save # =>  Valodation
      # sucess
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      # GET "/users/#{@user.id}" => show
    else
      # failure
      render 'new'
    end
  end
  
  #GET /users/:id/edit
  #params[:id] => :id
  def edit
    @user = User.find(params[:id])
    #app/views/users/edit.html.erb
  end
  
  #PATCH /users/:id
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # 更新に成功した場合を扱う。
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
    def user_params
      params.require(:user).permit(
      :name, :email, :password,
      :password_confirmation)
    end
end
