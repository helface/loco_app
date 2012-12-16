class AppointmentsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only:[:index] 
  before_filter :is_appt_host, only: [:make_available, :make_unavailable]
  before_filter :is_appt_traveler, only: [:book_appointment, :reject_appointment]
  def new
    @user = User.find_by_id(params[:user_id])
    @profile = @user.hostprofile
    @exchange_type = @user.hostprofile.exchange_type
    @appointment = Appointment.new
  end

  def create
    traveler = current_user
    @user = User.find_by_id(params[:user_id])
    @appointment = traveler.requested_appts.build(params[:appointment])
    if @user.hostprofile
       profile = @user.hostprofile
       @appointment.host_id = profile.id
       @appointment.exchange_type = profile.exchange_type
       @appointment.currency = profile.currency
       @appointment.price = profile.price
       @appointment.language_practice = profile.language_practice
    else
       redirect_to root_path
       return
    end
    if @appointment.save
      @user.hostprofile.increment_contact_count
      @appointment.make_check
      SiteMailer.mail_new_request(traveler, @user, @appointment).deliver
      flash[:success] = "your request has been sent"
      redirect_to user_appointment_path(traveler, @appointment)
    else
      render "new"
    end
  end

  def show
    @appointment = Appointment.find_by_id(params[:id])
    @traveler = @appointment.traveler
    @host = @appointment.host.user
    @user = User.find_by_id(params[:user_id])
  end
  
  def index
    store_nav_history
    
    @user = User.find_by_id(params[:user_id])
    @requested_appts = @user.requested_appts.order('date ASC').paginate(page: params[:page], per_page: 7)
    
    @appt_requests = @user.hostprofile.try(:appt_requests)
    if @appt_requests
      @appt_requests = @appt_requests.order('date ASC').paginate(page: params[:page], per_page:7)
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
    @appointment = Appointment.find_by_id(params[:appointment_id])
    if @appointment.make_available
       @appointment.host.increment_response_count
       SiteMailer.mail_available(@appointment.traveler, @appointment.host.user, @appointment).deliver
       flash[:success] = "Your appointment has been updated."
       redirect_to session[:prev]
    else
       flash[:error] = "appointment failed"
       redirect_to root_path
    end
  end
  
  def make_unavailable
     @appointment = Appointment.find_by_id(params[:appointment_id])
     if @appointment.make_unavailable
       @appointment.host.increment_response_count  
       flash[:success] = "Your appointment has been updated"
       redirect_to session[:prev]
     else
       flash[:error] = "appointment failed"
       redirect_to root_path
     end
  end
  
  def book_appointment
     @appointment = Appointment.find_by_id(params[:appointment_id])
     if @appointment.book_appointment
       SiteMailer.mail_booked(@appointment.traveler, @appointment.host.user, @appointment).deliver
       flash[:success] = "Congradulations! Your appointment is now booked."
     end
     redirect_to session[:prev]
  end
  
  def reject_appointment
     @appointment = Appointment.find_by_id(params[:appointment_id])
     if @appointment.reject_appointment
       flash[:success] = "Your appointment has been inactivated"
     end
     redirect_to session[:prev]
  end

  def cancel_appointment
     @appointment = Appointment.find_by_id(params[:appointment_id])
     if @appointment.cancel_appointment
       flash[:success] = "your appointment has been canceled"
     end
     redirect_to session[:prev]
  end
  
  #TODO: remove commented out lines
  def complete_appointment       
     @appointment = Appointment.find_by_id(params[:appointment_id])
     @user = User.find_by_id(params[:user_id])
          
     if @appointment.complete_appointment(current_user.id)
        @appointment.host.increment_completed_count
        
        if params[:review] == "host"
           redirect_to new_user_review_path(@user)  
        else
           redirect_to new_user_travelerreview_path(@user)
        end
     else
        flash[:error] = "Sorry, meeting could not be completed, #{@appointment.errors.full_messages}"
        redirect_to root_path
     end
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
