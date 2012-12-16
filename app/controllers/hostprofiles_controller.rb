class HostprofilesController < ApplicationController
  before_filter :not_host_already, only: [:new, :create]
  before_filter :is_user_self, only: [:update, :edit, :deactivate, :reactivate]
  before_filter :signed_in_user, only:[:new, :create, ]
    def new
      session[:form_params] ||= {}
      @user = current_user
      @hostprofile = @user.build_hostprofile(session[:form_params])
      @hostprofile.current_step = session[:form_step]
    end

    def create
      @user = current_user
      languages = params[:hostprofile][:language_tokens]
      if !languages.nil? && !languages.empty? 
        @user.language_tokens = languages
        @user.save
        sign_in @user
        params[:hostprofile].delete :language_tokens    
      end
      session[:form_params].deep_merge!(params[:hostprofile]) if params[:hostprofile]
      @hostprofile = @user.build_hostprofile(session[:form_params])
      if !@user.languages.nil? && !@user.languages.empty?
        @hostprofile.languages_filled = true
      end
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
      store_nav_history   
    end

    # PUT /users/1
    # PUT /users/1.json
    def update      
      if current_user?(@user) && @hostprofile.update_attributes(params[:hostprofile])
          flash[:success] = "Profile successfully updated"
          redirect_to session[:prev]
      else
          flash[:error] = "Sorry, we could not update your profile at this time."
          render 'edit'
      end
    end
    
    def deactivate
      @hostprofile.toggle!(:deactivated)
      @user.toggle_host_status
      sign_in @user
      appts = @hostprofile.appt_requests || []
      appts.each do |a|
        a.deactivate_appointment
      end
      flash[:success] = "Your host status has been deactivated"
      redirect_to current_user    
    end
    
    def reactivate
      @hostprofile.toggle!(:deactivated)
      @user.toggle_host_status
      sign_in @user
      flash[:success] = "Welcome back! Your host status has been reactivated"
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
      @user = @hostprofile.user
      redirect_to root_path unless !@hostprofile.nil? && current_user?(@user)
    end
end
