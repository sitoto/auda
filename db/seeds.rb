# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

## 增加权限
Permission.create(:action => 'manage', :subject => 'user', :description => '用户管理')
Permission.create(:action => 'manage', :subject => 'node', :description => '分类管理')
Permission.create(:action => 'manage', :subject => 'category', :description => '类目管理')
Permission.create(:action => 'manage', :subject => 'csvfile', :description => '文件管理')
Permission.create(:action => 'manage', :subject => 'pair', :description => '导入匹配管理')
Permission.create(:action => 'manage', :subject => 'property', :description => '标准属性管理')
Permission.create(:action => 'manage', :subject => 'product', :description => '数据商品管理')
Permission.create(:action => 'manage', :subject => 'resource', :description => '图片管理')
Permission.create(:action => 'manage', :subject => 'temproduct', :description => '源数据商品管理')
Permission.create(:action => 'manage', :subject => 'event', :description => '日志管理')

Permission.create(:action => 'read', :subject => 'category', :description => '类目查看')
Permission.create(:action => 'index', :subject => 'category', :description => '类目列表查看')
