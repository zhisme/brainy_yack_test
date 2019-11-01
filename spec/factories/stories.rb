FactoryBot.define do
  factory :story do
    sequence(:name) { |n| "MyName #{n}" }
    articles_kind_count { 0 }
    articles_count { 0 }
  end
end
