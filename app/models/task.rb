class Task < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 100 }

  before_save :set_max_due_date

  DEFAULT_DUE_DATE = Date.new(9999, 12, 31)

  def has_due_date? = due_date&.< DEFAULT_DUE_DATE

  def display_due_date = has_due_date? ? due_date : ""

  def complete!
    update(completed: true, completed_at: Time.current)
  end

  def uncomplete!
    update(completed: false, completed_at: nil)
  end

  def overdue? = due_date < Date.current

  private

    def set_max_due_date
      self.due_date = DEFAULT_DUE_DATE if due_date.blank?
    end
end
