class Game < ApplicationRecord
    has_many :participations
  
    def questions
      [
        "What will you do?",
        "Will you cooperate or betray?"
      ]
    end
  
    def evaluate_game(participations)
      if participations.size != 2
        return ["Game requires exactly two participants.", "Game requires exactly two participants."]
      end
  
      choice1 = participations.first.answers.first&.content&.downcase&.strip
      choice2 = participations.second.answers.first&.content&.downcase&.strip
  
      if choice1.nil? || choice2.nil?
        return ["Participants must answer the question.", "Participants must answer the question."]
      end
  
      if choice1 == "cooperate" && choice2 == "cooperate"
        ["Both cooperate: Minimal jail time.", "Both cooperate: Minimal jail time."]
      elsif choice1 == "betray" && choice2 == "cooperate"
        ["You betray: You go free.", "You cooperate: Maximum jail time."]
      elsif choice1 == "cooperate" && choice2 == "betray"
        ["You cooperate: Maximum jail time.", "You betray: You go free."]
      else
        ["Both betray: Moderate jail time.", "Both betray: Moderate jail time."]
      end
    end
  end