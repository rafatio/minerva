class BlazerQuery < ApplicationRecord
    belongs_to :run_role, :class_name => 'Role', :optional => true
    belongs_to :update_role, :class_name => 'Role', :optional => true
    belongs_to :delete_role, :class_name => 'Role', :optional => true
end
