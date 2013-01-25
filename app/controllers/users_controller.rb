class UsersController < ApplicationController

  before_filter :sign_in, except: [:new, :create]

  def index
    @user = User.find(current_user)
    render :show
  end
  alias :show :index

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to notes_path, notice: 'User was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
  end

  def regenerate_api_key
    current_user.regenerate_api_key

    redirect_to current_user, notice: 'Key was regenerated'
  end
end
