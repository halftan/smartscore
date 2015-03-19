# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
data = Datum.create([
  { label: 'test1', path: '/tmp/data1', size: '12345' },
  { label: 'test2', path: '/tmp/data2', size: '54321' },
])
