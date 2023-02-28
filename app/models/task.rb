# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  code        :string
#  description :text
#  due_date    :date             not null
#  name        :string
#  status      :string
#  transitions :string           default([]), is an Array
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#  owner_id    :bigint           not null
#
# Indexes
#
#  index_tasks_on_category_id  (category_id)
#  index_tasks_on_owner_id     (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (owner_id => users.id)
#
class Task < ApplicationRecord
  include AASM

  belongs_to :category
  belongs_to :owner, class_name: 'User'
  has_many :participating_users, class_name: 'Participant', dependent: :destroy
  has_many :participants, through: :participating_users, source: :user
  has_many :notes

  validates :participating_users, presence: true

  validates :name, :description, presence: true
  validates :name, uniqueness: true
  validate :due_date_validity

  accepts_nested_attributes_for :participating_users, reject_if: proc { |attr| attr['user_id'].blank? }, allow_destroy: true
  #reject_if: :all_blank
  #reject_if: proc { |attr| attr['address'].blank? } <--- Esto se pone si tenemos una validacion de presence en participating_users

  before_create :create_code
  after_create :send_email

  enum role: [:responsible, :collaborator ]

  aasm column: 'status' do
    state :pending, initial: true
    state :in_process, :finished

    after_all_transitions :audit_status_change

    event :start do
      transitions from: :pending, to: :in_process
    end

    event :finish do
      transitions from: :in_process, to: :finished
    end
  end

  def audit_status_change
    self.transitions = self.transitions.push(
      {
        from_state: aasm.from_state,
        to_state: aasm.to_state,
        current_event: aasm.current_event,
        timestamp: Time.zone.now
      }
    )
  end

  def due_date_validity
    return if due_date.blank? #El campo es obligatorio desde la migracion,
     #pero este ees un ejemplo de como seria
    return if due_date > Date.today
    errors.add :due_date, 'Invalid due date'

  end

  def create_code
    self.code = "#{owner_id}#{Time.now.to_i.to_s(36)}#{SecureRandom.hex(8)}"
  end

  def send_email
    Tasks::SendEmailJob.perform_in 15, self.id.to_s
  end

end

