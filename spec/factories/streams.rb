# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stream_with_post, class: "Stream" do
    lecturer
    streamable { create(:post) }
  end
end
