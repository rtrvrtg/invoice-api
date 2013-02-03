FactoryGirl.define do

  factory :auth do
    user { Faker::HipsterIpsum.words(rand(2)+2).join(" ") }
    pass { Faker::HipsterIpsum.words(rand(2)+2).join(" ") }
    apikey { DataMapper::Property::APIKey.generate }
  end

end
