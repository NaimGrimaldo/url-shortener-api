# frozen_string_literal: true

class LinkSerializer < ActiveModel::Serializer
  attributes :id, :original_url, :expires_at, :visits, :unique_key, :short_url
  attribute :visitors, if: -> { should_show_visitors }

  def should_show_visitors
    @instance_options[:with_visitors] && @object.visitors.any?
  end

  def short_url
    @object.short_url(@instance_options[:url_options])
  end

  def visitors
    @object.visitors.map do |visitor|
      VisitorSerializer.new(visitor, scope: scope, root: false, link: @object)
    end
  end
end
