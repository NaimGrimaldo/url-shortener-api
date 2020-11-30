class Visitor < ApplicationRecord
  belongs_to :link, inverse_of: :visitors
  has_many :visitor_agents, inverse_of: :visitor
  enum visitor_kind: %i[unique recurrent]

  before_validation :became_recurrent?

  def register(agent_data)
    Visitor.increment_counter(:visits, id)
    @agent = visitor_agents.where(agent: agent_data.name.to_s,
                                  os: agent_data.os.to_s).first_or_create
    process_agent_data
  end

  private

  def became_recurrent?
    return if new_record?

    return unless visitor_agents.count >= 1 || visits.positive?

    update_column :visitor_kind, :recurrent
  end

  def process_agent_data
    @agent.update_column :visited_at, updated_at
    VisitorAgent.increment_counter(:visits, @agent.id)
  end
end
