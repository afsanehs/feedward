class Appointment < ApplicationRecord
  belongs_to :employee, class_name: "User" #the employee is the one that is not company_admin
  belongs_to :employer, class_name: "User" #the employer is the one that is company_admin
  
  validates :start_date, 
    presence:true
  
  validates :end_date, 
    presence:true
  
  validates :title, 
    presence: {message: ": L'objet du rendez-vous est obligatoire."}
  
  validate :in_future_date?
  validate :end_date_is_after_start_date
  validate :overlaping_appointment?
  
  def duration 
    duration = (self.end_date.to_i - self.start_date.to_i)/(3600*24)
    return duration
  end 
  
  private 
  def in_future_date?
    if self.start_date.to_date < Time.now.to_date
      errors.add(:start_date, "can't be in the past")
    end
  end 

  def end_date_is_after_start_date
    return if end_date.blank? || start_date.blank?
    if end_date < start_date
      errors.add(:end_date, "end_date can't be before start_date") 
    end 
  end

  def overlaping_appointment?
    # vérifie dans tous les rendez-vous et si l'un d'eux tombe en même temps que le rendez-vous en entrée
    employer_appointments = Appointment.where(employer_id: employer_id)
    employer_appointments.each do |employer_appointment|
      if (employer_appointment.start_date..employer_appointment.end_date).overlaps?(start_date..end_date)
        errors.add(:end_date, "date is not available") 
      end 
    end 

    employee_appointments = Appointment.where(employee_id: employee_id)
    employee_appointments.each do |employee_appointment|
      if (employee_appointment.start_date..employee_appointment.end_date).overlaps?(start_date..end_date)
        errors.add(:end_date, "date is not available") 
      end 
    end 
  end

end
