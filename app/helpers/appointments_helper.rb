module AppointmentsHelper
  
  def is_appt_host?(appt)
    host_id = appt.host.user.id unless appt.nil?
    host_id == current_user.id    
  end
  
  def is_appt_traveler?(appt)
    appt.traveler_id == current_user.id
  end
  
end
