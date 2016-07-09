require "../src/leveldb"

db = LevelDB::DB.new("/tmp/leveldb_example_iterator")

db.put("age", "26")
db.put("name", "Sergey")
db.put("city", "Berlin")

db.each do |key, val|
  puts "#{key} = #{val}"
end

db.destroy
