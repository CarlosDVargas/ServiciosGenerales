# frozen_string_literal: true

class UserAccount < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  enum role: %i[employee assistant admin]

  belongs_to :employee, dependent: :destroy

  has_many :task_observations, dependent: :destroy
  has_many :tasks, through: :task_observations

  has_many :request_deny_reasons

  has_many :log_entries, dependent: :destroy

  has_many :reopen_reasons

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :employee
  end
end
