class Task < ApplicationRecord
  belongs_to :user
  validates :task_name, :task_description, :task_status, presence: true
end
