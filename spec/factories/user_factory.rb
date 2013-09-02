FactoryGirl.define do
  factory :user do
    nickname 'eight-ball'
    uuid { SecureRandom.uuid }
  end
end

