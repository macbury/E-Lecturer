# encoding: UTF-8

["Kraków"].each do |name|
  City.find_or_create_by_name(name)
end
["magister", "profesor", "doktor", "docent", "inżynier", "technik"].each do |title|
  puts "#{title} -> " + Title.find_or_create_by_name(title).inspect
end