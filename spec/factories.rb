FactoryBot.define do
  factory :round do
    participation { nil }
    user_move { "MyString" }
    player_move { "MyString" }
  end

  factory :move do
    player { nil }
    game { nil }
    round { 1 }
    move { "MyString" }
  end

  factory :player do
    name { "MyString" }
    strategy { "MyString" }
  end

    factory(:user) do
      email { Faker::Internet.email }
      password { Faker::Internet.password }
    end
  end