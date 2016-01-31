class Comment < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :author, class_name: "User"
  belongs_to :previous_state, class_name: "State"
  belongs_to :state

  validates :text, presence: true

  before_create :set_previous_state
  after_create :set_ticket_state

  delegate :project, to: :ticket

  scope :persisted, lambda { where.not(id: nil) }

  private
    def set_previous_state
      self.previous_state = ticket.state
    end

    def set_ticket_state
      ticket.state = state
      ticket.save!
    end
end
