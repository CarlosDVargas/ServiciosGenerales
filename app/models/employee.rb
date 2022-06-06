class Employee < ApplicationRecord
  validates :employee_id_card, presence: true, uniqueness: true

  has_one :user_account, dependent: :destroy

  accepts_nested_attributes_for :user_account, allow_destroy: true, reject_if: proc { |attr| attr["description"].blank? }

  enum employee_status: { "Activo": 1, "Inactivo": 0 }
end
