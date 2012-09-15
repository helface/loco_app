
class Status
  CHECK_SENT = 1
  AVAILABLE = 2
  NOT_AVAILABLE = 3
  BOOKED = 4
  REJECTED = 5
  COMPLETED = 6
  CANCELED = 7
  EXPIRED = 8
end

class Appointment < ActiveRecord::Base
  attr_accessible :date, :time, :message
  belongs_to :traveler, class_name: "user"
  belongs_to :host, class_name: "hostprofile"
  scope :booked, :conditions => ["status = ?", Status::BOOKED]
  scope :pending, :conditions => ["status = ? OR status = ?", Status::CHECK_SENT, Status::AVAILABLE]
  scope :inactive, :conditions => ["status = ? OR status = ? OR status = ? OR status = ? OR status = ?", Status::NOT_AVAILABLE, Status::REJECTED, Status::CANCELED, Status::COMPLETED, Status::EXPIRED ]
  scope :active, :conditions => ["status = ? OR status = ? OR status = ?", Status::BOOKED, Status::CHECK_SENT, Status::AVAILABLE]
  
  #TODO:remove comment below for production
  validate :correct_date
  
  TIME = ["Morning", "Noon", "Afternoon", "Evening", "Night"]
  def return_status_str(current_user_id)
     if is_host?(current_user_id)
        if self.status == Status::BOOKED && Date.today > self.date  
          return "pending completion"
        end
        case self.status
           when Status::CHECK_SENT then return "new!"
           when Status::BOOKED then return "booked"
           when Status::CANCELED then return "canceled"
           when Status::COMPLETED then return "completed"
           when Status::AVAILABLE then return "responded available"   
           when Status::NOT_AVAILABLE then return "responded unavailable"   
           when Status::REJECTED then return "canceled"  
           when Status::EXPIRED then return "expired"
         end
      elsif is_traveler?(current_user_id)
         if self.status == Status::BOOKED && Date.today > self.date  
           return "needs completion"
         end
         case self.status
            when Status::CHECK_SENT then return "pending host response"
            when Status::BOOKED then return "booked"
            when Status::CANCELED then return "canceled"
            when Status::COMPLETED then return "completed"
            when Status::AVAILABLE then return "host available"   
            when Status::NOT_AVAILABLE then return "host not available"   
            when Status::REJECTED then return "canceled"  
            when Status::EXPIRED then return "expired"       
         end
      end
  end  
  
  def make_check
    self.status = Status::CHECK_SENT
    self.save 
  end
  
  def make_available
     if self.status == Status::CHECK_SENT
        self.status = Status::AVAILABLE
        self.save
     end
  end
  
  def make_unavailable
     if self.status == Status::CHECK_SENT
         self.status = Status::NOT_AVAILABLE
         
         self.save 
     end
  end
  
  def book_appointment
     if self.status == Status::AVAILABLE
         self.status = Status::BOOKED
         self.save 
     end
  end
  
  # expire the appointment if an available check is not responded to within a day
  # or if the date on the appointment has passed  
  def expire_appointment
    if DateTime.now - self.updated_at.to_datetime > 1.day && self.status == Status::AVAILABLE
       self.status = Status::EXPIRED
       self.save
    elsif (DateTime.now.to_date > self.date) && (self.status == Status::CHECK_SENT || self.status == Status::AVAILABLE)
       self.status = Status::EXPIRED
       self.save
    end
  end
  
  def reject_appointment
    if self.status == Status::AVAILABLE
       self.status = Status::REJECTED
       self.save
    end
  end
  
  def complete_appointment
    if self.status == Status::BOOKED && DateTime.now.to_date > self.date
       self.status = Status::COMPLETED
       self.save
    end
  end
  
  def cancel_appointment
    if self.status == Status::BOOKED && self.date - DateTime.now < 2.days
       self.status = Status::CANCELED 
       self.save
    else
       return false
    end
  end 
  
  private
  
  def correct_date
    errors.add(:date, 'meeting date must be later than today') unless self.date >= DateTime.now.to_date || self.status == Status::EXPIRED
  end
  
  def is_host?(current_user_id)
    host = Hostprofile.find_by_id(self.host_id).user
    host.id == current_user_id
  end
  
  def is_traveler?(current_user_id)
     self.traveler_id == current_user_id  
  end
  
  
end
