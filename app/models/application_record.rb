class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  scope :inverse_of, ->(scope) { where(scope.arel.constraints.reduce(:and).not) }
end
