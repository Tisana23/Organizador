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
FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "Tarea #{n}" }
    sequence(:description) { |n| "Descripcion #{n}" }
    due_date { Date.today + 15.days }
    category
    association :owner, factory: :user
  
    factory :task_with_participants do
      transient do
        participants_count { 5 }
      end

      after(:build) do |task, evaluator|
        task.participating_users = build_list(
        :participant,
        evaluator.participants_count,
        task: task,
        role: 1
        )
        task.category.save
        task.owner.save
      end
    end
  end
end
