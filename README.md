# LevelDB <img src="https://raw.githubusercontent.com/greyblake/crystal-leveldb/master/images/crystal-leveldb-logo2.png" alt="crystal levedb" width="48">

Crystal binding for [LevelDB](https://github.com/google/leveldb).

[![Build Status](https://travis-ci.org/greyblake/crystal-leveldb.svg?branch=master)](https://travis-ci.org/greyblake/crystal-leveldb)

> LevelDB is a fast key-value storage library written at Google that provides an ordered mapping from string keys to string values.

## Installation

### Prerequisites

Debian:
```
apt-get install libleveldb-dev libleveldb1 libsnappy1
```

### shard.yml

```yaml
dependencies:
  leveldb:
    github: "greyblake/crystal-leveldb"
    version: "~> 0.1.0"
```

## Usage

### Basic usage

```crystal
require "leveldb"

# Create DB (if does not exist yet) and open
db = LevelDB::DB.new("./db")

# Put, get, delete
db.put("name", "Sergey")
db.get("name")  # => "Sergey"
db.delete("name")
db.get("name")  # => nil

# [], []= methods work the same
db["city"] = "Berlin"
db["city"]  # => "Berlin"

# Iterate through all the keys
db.each do |key, val|
  puts "#{key} = #{val}"
end

# Close database
db.close
db.closed? # => true
db.opened? # => false

# Close the database and remove all the data
db.destroy

# Remove all the keys, keep the database open
db.clear
```

### Snapshots

> Snapshots provide consistent read-only views over the entire state of the key-value store.

```crystal
db = LevelDB::DB.new("./db")

db.put("a", "1")
db.get("a")  # => "1"

snapshot = db.create_snapshot
db.delete("a")
db.get("a")  # => nil

db.set_snapshot(snapshot)
db.get("a")  # => "1"

db.unset_snapshot
db.get("a")  # => nil
```

## Contributors

- [greyblake](https://github.com/greyblake) Sergey Potapov - creator, maintainer
