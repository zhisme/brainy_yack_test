FactoryBot.define do
  factory :article do
    sequence(:name) { |n| "MyName #{n}" }
    text { 'MyText' }
    kind { 1 }
    association :story, strategy: :create
  end
end
