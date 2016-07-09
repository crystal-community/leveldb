require "./src/leveldb"

db = LevelDB::DB.new("/tmp/leveldb_test")

data = Hash(String, String).new
10.times do |i|
  key = "key-#{i.to_s}"
  value = "value-#{i.to_s}"
  data[key] = value * 10
end
data


start_time = Time.now
data.each do |key, val|
  db.put(key, val)
  puts db.get(key)
end
time = Time.now - start_time
puts time.to_f

puts (1000_000 / time.to_f / 1000).round * 1000
