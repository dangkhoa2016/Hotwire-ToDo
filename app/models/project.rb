class Project < ApplicationRecord
  scope :unarchived, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }

  belongs_to :owner, class_name: "User"
  has_many :tasks, dependent: :destroy
  has_many :project_members, dependent: :destroy
  has_many :members, through: :project_members, source: :user

  after_create_commit :add_owner_to_members

  validates :name, presence: true, length: { maximum: 100 }

  def display_name
    dedicated ? I18n.t("project.inbox") : name
  end

  private

    def add_owner_to_members
      members << owner
    end
end