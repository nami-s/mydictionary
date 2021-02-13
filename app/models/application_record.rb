class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  ransacker :created_at, callable: proc { Arel.sql('DATE(created_at)') }
end
