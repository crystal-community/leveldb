require "./src/leveldb"

N = 100_000

db = LevelDB::DB.new("./db", compression: true)

data = Hash(String, String).new
N.times do |i|
  key = "key-#{i.to_s}"
  value = "#{key} : value-#{i.to_s}"
  data[key] = value * 1000
end

puts "data generated"

start_time = Time.now
data.each do |key, val|
  db.put(key, val)
end
duration = Time.new - start_time
db.close

speed = (N / duration.to_f / 10).round * 10
puts "#{speed} ops /sec "
system "du ./db -sh"

db.destroy
