FactoryGirl.define do
  factory :auction do
    title "MyString"
    details "MyText"
    ends_on DateTime.parse "2014-11-28 10:09:29"
    reserve_price 10
  end

end
