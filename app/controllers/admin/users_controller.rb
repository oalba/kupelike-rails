module Admin
  class UsersController < ApplicationController
    # before_filter :authenticate_user!
    # devise :database_authenticatable, :registerable,
    #        :recoverable, :rememberable, :trackable, :validatable
    before_action :authenticate_user!
    load_and_authorize_resource
    # after_action :load_and_authorize_resource
    # load_and_authorize_resource

    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
    end

    def new
      @user = User.new
    end

    def create
      # @user = user.new(user_params)
      @user = User.new(user_params)

      if @user.save
        flash[:success] = "User created successfully."
        redirect_to admin_users_path
      else
        flash[:error] = "User could not be created."
        render 'new'
      end
      # render plain: params[:user].inspect
    end

    def edit
      # authorize! :edit, @user
      @user = User.find(params[:id])
    end

    # def update
    #   @user = User.find(params[:id])

    #   if @user.update(user_params)
    #     redirect_to admin_users_path
    #   else
    #     render 'edit'
    #   end
    # end

    def destroy
      @user = User.find(params[:id])
      if @user.destroy
        flash[:success] = "User deleted successfully."
      else
        flash[:error] = "User could not be deleted."
      end
      redirect_to admin_users_path
      # index
    end

    def update
      @user = User.find(params[:id])
      if user_params[:password].blank?
        @user.update_without_password(user_params)
      else
        @user.update_attributes(user_params)
      end
      if @user.errors.blank?
        flash[:success] = "User updated successfully."
        if current_user.role == "admin"
          redirect_to admin_users_path
        else
          redirect_to index_path
        end
      else
        flash[:error] = "User could not be updated."
        render :edit
      end
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :surnames, :address, :phone, :role_id, :place_id)
    end
  end
end
