
class State < ActiveRecord::Base

  ### recursive self-reference - use "generic" node??
  ## has_many :nodes, class_name: 'State', foreign_key: 'state_id'
  # belongs_to :parent,  class_name: 'State', foreign_key: 'state_id'
  # has_many   :states,  class_name: 'State', foreign_key: 'state_id'  ## substates

end