module AppointmentsHelper
  
  def is_appt_host?(appt)
    host = Hostprofile.find_by_id(appt.host_id).user
    host.id == current_user.id
  end
  
  def is_appt_traveler?(appt)
    appt.traveler_id == current_user.id
  end
  
end
