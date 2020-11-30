# frozen_string_literal: true

RSpec.shared_examples 'has_many relations' do |excluded_columns, excluded_tables|
  # has_many relation.
  excluded_columns = [excluded_columns] unless excluded_columns.is_a? Array
  excluded_tables = [excluded_tables] unless excluded_tables.is_a? Array

  ActiveRecord::Base.connection.tables.each do |table|
    next if excluded_tables.include? table

    # constant = table.singularize.camelize.constantize rescue nil
    begin
      constant = table.singularize.camelize.constantize
    rescue StandardError
      constant = nil
    end
    next unless constant

    model = described_class.to_s.underscore
    constant.column_names.each do |c|
      next if excluded_columns.include? c
      next unless c == "#{model}_id"

      it { is_expected.to have_many(table.to_sym).inverse_of(model.to_sym) }
    end
  end
end
