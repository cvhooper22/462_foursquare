class UsersController < ApplicationController
  include ApplicationHelper
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @current_user = current_user ? current_user.first : nil
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @is_current_user = is_current_user?
    if @user.is_authorized
      checkin_count = @is_current_user ? 10 : 1
      client = Foursquare2::Client.new(:oauth_token => @user.token)
      @checkins = client.user_checkins(:limit => checkin_count, :sort => 'newestfirst', :v => '20140806')
    end
    # byebug
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    if auth_hash
      @user = User.from_omniauth(auth_hash, current_user.first.username) 
    else
      @user = User.new(user_params)
      session[:current_user] = params[:user][:username]
    end
    respond_to do |format|
      if @user.save
        format.html { redirect_to action: "show", id: @user.username }
        format.json { render :index, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if is_number? params[:id]
        @user = User.by_foursquare_id(params[:id]).first
      else
        @user = User.by_username(params[:id]).first
      end
      @user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username)
    end

    def auth_hash
      request.env['omniauth.auth']
    end

    def is_current_user?
      return false unless current_user && @user
      current_user_id = current_user.first.foursquare_id
      return current_user_id == @user.foursquare_id
    end
end
