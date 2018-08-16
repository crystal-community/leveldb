require "../src/leveldb"

# Create (if does not exist yet) and open DB
db = LevelDB::DB.new("/tmp/leveldb_example_basic_usage")

# Put, get, delete
db.put("name", "Sergey")
db.get("name") # => "Sergey"
db.delete("name")
db.get("name") # => nil

# Iterate through all the keys
db.each do |key, val|
  puts "#{key} = #{val}"
end

# Close database
db.close

# Remove database with all the data
db.destroy
