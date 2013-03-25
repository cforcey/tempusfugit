class Admin::UsersController < Admin::AdminController
  
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_roles, only: [:edit, :update, :new, :create]

  # GET /users
  # GET /users.json
  def index
    @users = User.order_by_sort_name
  end

  # GET /users/1
  # GET /users/1.json
  def show
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
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_user_path(@user), notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_user_path(@user), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    # to help protect against a user deleting themselves, we take
    # the unusual step of assigning the current_user to an attribute
    # on the model and then run a before_destroy check.  The
    # advantage (arguable) of this over the standard controller
    # based approach (testing right here and redirecting) is that
    # the model takes a safe approach -- if the variable matches
    # or is not set, it will block the deletion.  If new controllers,
    # command lines, REST API calls are written, this will enforce
    # this critical rule by disallowing deletion until the user is passed.
    @user.passed_current_user = current_user
    success = @user.destroy
    respond_to do |format|
        if success
          format.html { redirect_to admin_users_url, :notice => 'User was successfully deleted.' }
          format.json { head :no_content }
        else
          format.html { redirect_to admin_users_url, :alert => @user.errors.full_messages.to_sentence }
          format.json { render json: @user.errors, status: :forbidden }
        end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    
    def set_roles  
      # new and edit make use of this instance variable to show check boxes for roles
      @valid_roles = User.valid_roles.map { |r| [r,r.to_s.humanize] }
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, 
        :first, :middle, :last, :organization, :message, :hourly_rate, :time_zone, {:roles => []})
    end
end

