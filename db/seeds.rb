# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

## 增加权限
Permission.find_or_create_by(:action => 'manage', :subject => 'user', :description => '用户管理')


Permission.find_or_create_by(:action => 'manage', :subject => 'node', :description => '分类管理')
Permission.find_or_create_by(:action => 'manage', :subject => 'category', :description => '类目管理')
Permission.find_or_create_by(:action => 'manage', :subject => 'csvfile', :description => '文件管理')
Permission.find_or_create_by(:action => 'manage', :subject => 'pair', :description => '导入匹配管理')
Permission.find_or_create_by(:action => 'manage', :subject => 'property', :description => '标准属性管理')
Permission.find_or_create_by(:action => 'manage', :subject => 'product', :description => '数据项(商品)管理')
Permission.find_or_create_by(:action => 'manage', :subject => 'resource', :description => '图片管理')
#Permission.find_or_create_by(:action => 'manage', :subject => 'temproduct', :description => '源数据商品管理')
Permission.find_or_create_by(:action => 'manage', :subject => 'manage', :description => '系统管理')

#category
Permission.find_or_create_by(:action => 'read', :subject => 'category', :description => '类目查看')
Permission.find_or_create_by(:action => 'create', :subject => 'category', :description => '创建类目')
Permission.find_or_create_by(:action => 'destroy', :subject => 'category', :description => '删除类目')
Permission.find_or_create_by(:action => 'update', :subject => 'category', :description => '修改类目')
Permission.find_or_create_by(:action => 'node', :subject => 'category', :description => '类目分类查看')

#node
Permission.find_or_create_by(:action => 'read', :subject => 'node', :description => '分类查看')
Permission.find_or_create_by(:action => 'create', :subject => 'node', :description => '创建分类')
Permission.find_or_create_by(:action => 'destroy', :subject => 'node', :description => '删除分类')
Permission.find_or_create_by(:action => 'update', :subject => 'node', :description => '修改分类')

#csvfile
Permission.find_or_create_by(:action => 'read', :subject => 'csvfile', :description => '文件查看')
Permission.find_or_create_by(:action => 'create', :subject => 'csvfile', :description => '上传文件')
Permission.find_or_create_by(:action => 'destroy', :subject => 'csvfile', :description => '删除文件')
Permission.find_or_create_by(:action => 'update', :subject => 'csvfile', :description => '修改文件')

#pair
Permission.find_or_create_by(:action => 'read', :subject => 'pair', :description => '匹配查看')
Permission.find_or_create_by(:action => 'create', :subject => 'pair', :description => '创建匹配')
Permission.find_or_create_by(:action => 'destroy', :subject => 'pair', :description => '删除匹配')
Permission.find_or_create_by(:action => 'update', :subject => 'pair', :description => '修改匹配')
Permission.find_or_create_by(:action => 'doing', :subject => 'pair', :description => '查看编辑中数据项')
Permission.find_or_create_by(:action => 'agree', :subject => 'pair', :description => '查看已审核数据项')

#property
Permission.find_or_create_by(:action => 'read', :subject => 'property', :description => '标准属性查看')
Permission.find_or_create_by(:action => 'create', :subject => 'property', :description => '创建标准属性')
Permission.find_or_create_by(:action => 'destroy', :subject => 'property', :description => '删除标准属性')
Permission.find_or_create_by(:action => 'update', :subject => 'property', :description => '修改标准属性')

#product
Permission.find_or_create_by(:action => 'read', :subject => 'product', :description => '数据项查看')
Permission.find_or_create_by(:action => 'create', :subject => 'product', :description => '创建数据项')
Permission.find_or_create_by(:action => 'destroy', :subject => 'product', :description => '删除数据项')
Permission.find_or_create_by(:action => 'update', :subject => 'product', :description => '修改数据项')

#resource
Permission.find_or_create_by(:action => 'read', :subject => 'resource', :description => '图片查看')
Permission.find_or_create_by(:action => 'create', :subject => 'resource', :description => '创建图片')
Permission.find_or_create_by(:action => 'destroy', :subject => 'resource', :description => '删除图片')
Permission.find_or_create_by(:action => 'update', :subject => 'resource', :description => '修改图片')

#manage
Permission.find_or_create_by(:action => 'export', :subject => 'manage', :description => '数据导出')
Permission.find_or_create_by(:action => 'event', :subject => 'manage', :description => '系统日志')

