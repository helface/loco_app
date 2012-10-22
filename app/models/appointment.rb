
class Status
  CHECK_SENT = 1
  AVAILABLE = 2
  NOT_AVAILABLE = 3
  BOOKED = 4
  REJECTED = 5
  COMPLETED = 6
  CANCELED = 7
  EXPIRED = 8
  DEACTIVATED = 9
end

class Appointment < ActiveRecord::Base
  attr_accessible :date, :time, :message, :groupsize, :flexible
  belongs_to :traveler, class_name: "user"
  belongs_to :host, class_name: "hostprofile"
  scope :booked, :conditions => ["status = ? AND date >= ?", Status::BOOKED, Date.today]
  scope :host_incomplete, :conditions => ["status = ? AND host_completed = ? AND date < ?", Status::BOOKED, false, Date.today]
  scope :traveler_incomplete, :conditions => ["status = ? AND traveler_completed = ? AND date < ?", Status::BOOKED, false, Date.today] 
  scope :pending, :conditions => ["status = ? OR status = ?", Status::CHECK_SENT, Status::AVAILABLE]
  scope :inactive, :conditions => ["status = ? OR status = ? OR status = ? OR status = ? OR status = ? OR status = ?", Status::NOT_AVAILABLE, Status::REJECTED, Status::CANCELED, Status::COMPLETED, Status::EXPIRED, Status::DEACTIVATED ]
  scope :active, :conditions => ["status = ? OR status = ? OR status = ?", Status::BOOKED, Status::CHECK_SENT, Status::AVAILABLE]
  
  #TODO:remove comment below for production
  validate :correct_date
  validates_presence_of :date, :groupsize
  validates_presence_of :price, :currency, :if => :exchange_is_money?
  validates_presence_of :language_practice, :if =>:exchange_is_lang?
  
  validates :groupsize, :numericality=>{:only_integer => true, :greater_than_or_equal_to=>1}
  
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
           when Status::DEACTIVATED then return "host no longer active"
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
            when Status::DEACTIVATED then return "host no longer active"
              
         end
      end
  end  
  
  def exchange_is_money?
     exchange_type == "money"
   end

   def exchange_is_lang?
     exchange_type == "language practice"
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
     if self.status == Status::AVAILABLE && self.date > Date.today
         self.status = Status::BOOKED
         self.save 
     end
  end
  
  def deactivate_appointment
    self.status = Status::DEACTIVATED unless self.status == Status::BOOKED
    self.save
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
  
  def complete_appointment(id)
    #TODO: take out equal sign
    if self.status == Status::BOOKED && DateTime.now.to_date >= self.date
       if self.host_id == id
         self.host_completed = true
       elsif self.traveler_id == id
         self.traveler_completed = true
       else
         return false
       end       
       if host_completed? && traveler_completed?
         self.status = Status::COMPLETED
       end
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
  
  def host_completed?
    return self.host_completed
  end
  
  def traveler_completed?
    return self.traveler_completed
  end
  
  private
  
  def correct_date
    errors.add(:date, 'meeting date must be later than today') unless self.date >= DateTime.now.to_date || self.status == Status::EXPIRED || self.status == Status::COMPLETED || self.status == Status::BOOKED
  end
  
  def is_host?(current_user_id)
    host = Hostprofile.find_by_id(self.host_id).user
    host.id == current_user_id
  end
  
  def is_traveler?(current_user_id)
     self.traveler_id == current_user_id  
  end
  
  
end
