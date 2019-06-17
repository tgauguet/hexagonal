module Filterable
  extend ActiveSupport::Concern

  def filter filtering_params
    results = self

    filtering_params.each do |key, value|
      results = results.public_send(key, value) if value.present?
    end
    results
  end

  def sort_by column, direction
    direction = %w[desc asc].include?(direction) ? direction : 'asc'
    column = self.column_names.include?(column) ? column : 'created_at'

    self.order("#{column} #{direction}")
  end
end
