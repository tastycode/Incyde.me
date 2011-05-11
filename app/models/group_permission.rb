
class GroupPermission < ActiveRecord::Base
  belongs_to :permission
  belongs_to :group
end

