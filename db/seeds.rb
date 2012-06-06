# encoding: UTF-8

["Kraków"].each do |name|
  City.find_or_create_by_name(name)
end
["mgr", "prof"].each do |title|
  Title.find_or_create_by_name(title)
end