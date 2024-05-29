class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :participation

  validates :content, presence: true

  before_validation :debug_answer

  private

  def debug_answer
    Rails.logger.debug "Answer content: #{content.inspect}"
    Rails.logger.debug "Question: #{question.inspect}"
    Rails.logger.debug "Participation: #{participation.inspect}"
  end
end