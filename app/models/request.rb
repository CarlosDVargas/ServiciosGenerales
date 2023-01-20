# frozen_string_literal: true

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
  validates :work_type, presence: true
  validates :work_description, presence: true

  has_many :tasks
  has_many :employees, through: :tasks
  belongs_to :campus

  has_many :request_deny_reasons
  accepts_nested_attributes_for :request_deny_reasons, allow_destroy: true, reject_if: proc { |attr|
                                                                                         attr['description'].blank?
                                                                                       }
  belongs_to :work_location
  accepts_nested_attributes_for :work_location

  has_one :feedback, dependent: :destroy

  has_many :log_entries, dependent: :destroy
end
