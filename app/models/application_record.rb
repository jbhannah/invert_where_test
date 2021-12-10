class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  scope :inverse_of, ->(scope) { where(klass.send(scope).arel.constraints.reduce(:and).not) }
end
