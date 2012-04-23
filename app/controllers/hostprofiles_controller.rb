class HostprofilesController < UsersController    
#TODO: fix these verifications!
before_filter :not_host_already, only: [:new, :create]

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

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @hostprofile = Hostprofile.find(params[:id])
    @hostprofile.destroy
    current_user.toggle!(:is_host)
    sign_in current_user
    redirect_to current_user
  end
    
    def not_host_already
      if host_user?(current_user)
        redirect_to(root_path)
      end
    end 

end
