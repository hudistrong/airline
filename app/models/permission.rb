class Permission < ApplicationRecord
  has_many :role_permissions, dependent: :destroy
  has_many :roles, dependent: :restrict_with_error, through: :role_permissions

    def default_permission
    for value in 1..4
      if value == 1
        permission = Permission.new
        permission.action = "manage"
        permission.subject = "roles"
        permission.description = "角色"
        permission.group_name = "权限管理"
        permission.url = "/admin/roles"
        if Permission.where(subject: permission.subject).first.blank?
          permission.save
        end
      end
      if value == 2
        permission = Permission.new
        permission.action = "manage"
        permission.subject = "users"
        permission.description = "用户"
        permission.group_name = "权限管理"
        permission.url = "/admin/users"
        if Permission.where(subject: permission.subject).first.blank?
          permission.save
        end
      end
      if value == 3
        permission = Permission.new
        permission.action = "manage"
        permission.subject = "permissions"
        permission.description = "权限资源"
        permission.group_name = "权限管理"
        permission.url = "/admin/permissions"
        if Permission.where(subject: permission.subject).first.blank?
          permission.save
        end
      end
      if value == 4
        permission = Permission.new
        permission.action = "manage"
        permission.subject = "admin"
        permission.description = "首页"
        permission.group_name = "首页"
        permission.url = "/admin"
        if Permission.where(subject: permission.subject).first.blank?
          permission.save
        end
      end
    end
  end

end
