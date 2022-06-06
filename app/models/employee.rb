class Employee < ApplicationRecord
  validates :employee_id_card, presence: true

  enum employee_status: { "Activo": 1, "Inactivo": 0 }

end
