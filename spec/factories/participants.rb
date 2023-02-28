# == Schema Information
#
# Table name: participants
#
#  id         :bigint           not null, primary key
#  role       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  task_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_participants_on_task_id  (task_id)
#  index_participants_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (task_id => tasks.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :participant do
    association :user
    trait :responsible do
      role { Participant::ROLES[:responsible] }
    end
  
    trait :follower do
      role { Participant::ROLES[:follower] }
    end

    after(:build) do |participant, _|
      participant.user.save
    end
  end
end
