# frozen_string_literal: true

class UserAccount < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  validates :id_card, presence: true, uniqueness: true

  enum role: %i[admin worker]

  enum status: { Inactivo: 0, Activo: 1 }

  has_many :task_observations, dependent: :destroy

  has_many :tasks, through: :task_observations

  has_many :request_deny_reasons

  has_many :log_entries, dependent: :destroy

  has_many :reopen_reasons

  has_many :tasks

  has_many :requests, through: :tasks

  belongs_to :campus

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :worker
  end

  def set_default_status
    self.status ||= :active
  end

  def change_status
    status = self.status
    self.status = status == 'active' ? 'inactive' : 'active'
    save
  end

  def active_requests
    requests.where(id: tasks.where(active: true, user_account_id: self.id).pluck(:request_id))
  end
end
