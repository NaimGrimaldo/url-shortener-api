# frozen_string_literal: true

RSpec.shared_examples 'belongs_to relations' do |excluded_columns|
  # belongs_to relation.
  excluded_columns = [excluded_columns] unless excluded_columns.is_a? Array

  described_class.column_names.each do |c|
    next unless c.ends_with?('_id')
    next if excluded_columns.include? c

    relation = c.gsub('_id', '')
    model = described_class.to_s.underscore.pluralize
    it { is_expected.to belong_to(relation.to_sym).inverse_of(model.to_sym) }
  end
end
