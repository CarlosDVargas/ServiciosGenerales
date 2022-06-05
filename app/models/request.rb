class Request < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save { self.requester_mail = requester_mail.downcase }
  validates :requester_name, presence: true
  validates :requester_extension, presence: true
  validates :requester_phone, presence: true
  validates :requester_id, presence: true
  validates :requester_mail, presence: true,
                             format: { with: VALID_EMAIL_REGEX }
  validates :requester_type, presence: true
  validates :work_building, presence: true
  validates :work_location, presence: true
  validates :work_type, presence: true
  validates :work_description, presence: true

  enum student_association: { assosiation: "Asociación Estudiantil", feucr: "FEUCR" }
  enum requester_type: { teacher: "Docente", administrator: "Administativo", student: "Estudiante" }
  enum work_type: { repair: "Reparación", maintenance: "Mantenimiento", other_type: "Otro" }
  enum work_building: { gym: "Gimnasio", sciencie_labs: "Laboratiorios Ciencias Generales", cafeteria: "Comedor", other_building: "Otro" }

  attr_reader :requester_type, :work_type, :work_building, :student_association
end
