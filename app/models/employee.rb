# frozen_string_literal: true

class Employee < ApplicationRecord
  validates :employee_id_card, presence: true, uniqueness: true

  has_one :user_account, dependent: :destroy
  accepts_nested_attributes_for :user_account, allow_destroy: true, reject_if: proc { |attr|
    attr['description'].blank?
  }

  has_many :tasks
  has_many :requests, through: :tasks
  belongs_to :campus
  enum employee_status: { "Activo": 1, "Inactivo": 0 }
  enum employee_type: { "Trabajador": 0, "Administrador": 1 }

  def active_requests
    requests.where(id: tasks.where(active: true, user_account_id: self.id).pluck(:request_id))
  end
end
