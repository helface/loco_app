class HostprofilesController < UsersController    
#TODO: fix these verifications!
#TODO: Save host profile and only flip is_host on destroy
before_filter :not_host_already, only: [:new, :create]
before_filter :is_user_self, only: :destroy
  def new
    @hostprofile = current_user.build_hostprofile
  end

  def create  
    @hostprofile = current_user.build_hostprofile(params[:hostprofile])
    if @hostprofile.save 
        current_user.toggle!(:is_host)
        sign_in current_user
        flash[:success] = "Host profile successfully created"
        redirect_to current_user
    else
        flash[:error] = "Failed to create host profile"
        redirect_to users_path
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    if @user.update_attributes(params[:user])
        flash[:success] = "Profile successfully updated"
        sign_in @user
        redirect_to @user
    else
        render 'edit'
    end
  end

  def destroy
    if @hostprofile.destroy
      current_user.toggle!(:is_host)
      sign_in current_user
    else
      flash[:error] = "sorry, host profile failed to delete"
    end
    redirect_to current_user
  end
    #making sure only non-hosts can become hosts
    def not_host_already
      if host_user?(current_user)
        redirect_to(root_path)
      end
    end 
    
    #making sure that only the user self can delete its own profile
    def is_user_self
      @hostprofile = Hostprofile.find(params[:id])
      unless @hostprofile.user_id == current_user.id       
        redirect_to root_path
      end
    end

end
