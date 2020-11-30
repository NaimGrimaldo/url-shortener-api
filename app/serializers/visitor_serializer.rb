class VisitorSerializer < ActiveModel::Serializer
  attributes :id, :ip, :visits, :visitor_kind, :visits_percentage
  has_many :visitor_agents

  def visits_percentage
    visitor_visits = @object.visits.to_f
    total_visits = @object.link.visits.to_f
    (visitor_visits / total_visits) * 100
  end
end
