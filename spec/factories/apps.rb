FactoryGirl.define do

  factory :app do
    name { Faker::HipsterIpsum.words(rand(2)+2).join(" ") }
    stub { name.downcase.gsub(/[^a-z0-9]/, '-') }
    start_at { 1 }
  end

end
