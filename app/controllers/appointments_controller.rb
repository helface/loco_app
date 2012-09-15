class AppointmentsController < ApplicationController
  before_filter :correct_user, only:[:index] 
  before_filter :is_appt_host, only: [:make_available, :make_unavailable]
  before_filter :is_appt_traveler, only: [:book_appointment, :reject_appointment, :complete_appointment]
  def new
    @user = User.find_by_id(params[:user_id])
    @appointment = Appointment.new
  end

  def create
    @user = User.find_by_id(params[:user_id])
    traveler = current_user
    host = User.find_by_id(params[:user_id])
    @appointment = traveler.requested_appts.build(params[:appointment])
    if host.hostprofile
       @appointment.host_id = host.hostprofile.id
    else
       redirect_to root_path
       return
    end
    if @appointment.save
      host.hostprofile.increment_contact_count
      @appointment.make_check
      flash[:success] = "your request has been sent"
      redirect_to user_appointment_path(traveler, @appointment)
    else
      render "new"
    end
  end

  def show
    @appointment = Appointment.find_by_id(params[:id])
    @traveler = User.find_by_id(@appointment.traveler_id)
    profile = Hostprofile.find_by_id(@appointment.host_id)
    @host = profile.user
    @user = User.find_by_id(params[:user_id])
  end
  
  def index
    store_nav_history
    
    @user = User.find_by_id(params[:user_id])
    @requested_appts = @user.requested_appts.order('updated_at DESC').paginate(page: params[:page], per_page: 7)
    
    @appt_requests = @user.hostprofile.try(:appt_requests)
    if @appt_requests
      @appt_requests = @appt_requests.order('updated_at DESC').paginate(page: params[:page], per_page:7)
      
      @appt_requests.each do |req|    
          req.expire_appointment
      end
    end
    
    #Expire any outdated appointments. 
    # TODO: Possibly move this into background process
    @requested_appts.each do |req|
      req.expire_appointment
    end
  end
  
  def make_available 
    profile = Hostprofile.find_by_id(@appointment.host_id)
    if @appointment.make_available
       profile.increment_response_count
       redirect_to user_appointment_path(current_user, @appointment)
    else
       flash[:error] = "appointment failed"
       redirect_to root_path
    end
  end
  
  def make_unavailable
     profile = Hostprofile.find_by_id(@appointment.host_id)
     if @appointment.make_unavailable
       profile.increment_response_count  
       redirect_to user_appointment_path(current_user, @appointment)
     else
       flash[:error] = "appointment failed"
       redirect_to root_path
     end
  end
  
  def book_appointment
     @appointment.book_appointment
     redirect_to user_appointment_path(current_user, @appointment)
  end
  
  def reject_appointment
     @appointment.reject_appointment
     redirect_to user_appointment_path(current_user, @appointment)
  end

  def cancel_appointment
     @appointment = Appointment.find_by_id(params[:appointment_id])
     @appointment.cancel_appointment
     redirect_to user_appointment_path(current_user, @appointment)
  end
  
  def complete_appointment       
     @appointment = Appointment.find_by_id(params[:appointment_id])
     profile = Hostprofile.find_by_id(@appointment.host_id)
     @user = Hostprofile.find_by_id(@appointment.host_id).user     
     #render "reviews/new_host_review"
     redirect_to new_user_review_path(@user)
     #if @appointment.complete_appointment
      #  profile = Hostprofile.find_by_id(@appointment.host_id)
       # @user = Hostprofile.find_by_id(@appointment.host_id).user
      #  profile.increment_completed_count  
       # @review = Review.new
        #render "response"
     #else
      #  redirect_to root_path
     #end
  end
  
  private
  
  def correct_user    
    @user=User.find_by_id(params[:user_id])
    redirect_to(root_path) unless current_user?(@user)
  end
  
  def is_appt_host
    @appointment = Appointment.find_by_id(params[:appointment_id])
    host = Hostprofile.find_by_id(@appointment.host_id).user
    redirect_to root_path unless host.id == current_user.id
  end
  
  def is_appt_traveler
    @appointment = Appointment.find_by_id(params[:appointment_id])
    redirect_to root_path unless @appointment.traveler_id == current_user.id
  end
end
