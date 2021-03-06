class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  scope :inverse_of, ->(scope) { self.and(klass.send(scope).invert_where) }
end
