class HostprofilesController < ApplicationController
  #TODO: fix these verifications!
  #TODO: Save host profile and only flip is_host on destroy
  before_filter :not_host_already, only: [:new, :create]
  before_filter :is_user_self, only: :destroy
    def new
      session[:form_params] ||= {}
      @user = current_user
      @hostprofile = @user.build_hostprofile(session[:form_params])
      @hostprofile.current_step = session[:form_step]
    end

    def create
      @user = current_user
      session[:form_params].deep_merge!(params[:hostprofile]) if params[:hostprofile]
      @hostprofile = @user.build_hostprofile(session[:form_params])
      @hostprofile.current_step = session[:form_step]
      if params[:back_button]
        @hostprofile.previous_step
      elsif @hostprofile.last_step?
        if @hostprofile.save
          @user.toggle_host_status
          sign_in @user
          flash[:success] = "Host profile successfully created"
          redirect_to @user
          return
        else
          flash.now[:error] = "Failed to create host profile"
          render 'new'
          return
        end
      else  
        @hostprofile.next_step
      end
      session[:form_step] = @hostprofile.current_step

      if @hostprofile.new_record?
        render 'new'
      else
        flash[:success] = "Profile saved."
        session[:form_step] = session[:form_step] = nil
        redirect_to @hostprofile
      end 
    end

    def edit
      @hostprofile = Hostprofile.find_by_id(params[:id])
      @user = @hostprofile.user    
    end

    # PUT /users/1
    # PUT /users/1.json
    def update
      @hostprofile = Hostprofile.find_by_id(params[:id])
      @user = @hostprofile.user
      if @hostprofile.update_attributes(params[:hostprofile])
          flash[:success] = "Profile successfully updated"
          redirect_to current_user
      else
          render 'edit'
      end
    end

    def destroy
      if @hostprofile.destroy
        current_user.toggle_host_status
        sign_in current_user
      else
        flash[:error] = "sorry, host profile failed to delete"
      end
      redirect_to current_user
    end

    #making sure only non-hosts can become hosts
    #TODO: make this into a user class method
    def not_host_already
      if host_user?(current_user) || current_user.nil?
        redirect_to(root_path)
      end
    end  

    #making sure that only the user self can delete his/her own profile
    def is_user_self
      @hostprofile = Hostprofile.find(params[:id])
      unless current_user?(User.find(@hostprofile.user_id))
        #unless @hostprofile.user_id == current_user.id       
        redirect_to root_path
      end
    end
end
