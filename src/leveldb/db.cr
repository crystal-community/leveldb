module LevelDB
  class DB
    @errptr : Pointer(UInt32)

    def initialize(path : String)
      @error_slice = Slice(UInt32).new(1)
      @errptr = @error_slice.to_unsafe

      options = LibLevelDB.leveldb_options_create
      LibLevelDB.leveldb_options_set_create_if_missing(options, 1)

      @db = LibLevelDB.leveldb_open(options, "/tmp/leveldb_test", @errptr)
      check_error!
    end

    def put(key, value)
      write_options = LibLevelDB.leveldb_writeoptions_create
      LibLevelDB.leveldb_put(@db, write_options, key, key.bytesize, value, value.bytesize, @errptr)
    end

    def get(key)
      read_options = LibLevelDB.leveldb_readoptions_create()
      vallen = 0_u64
      val = LibLevelDB.leveldb_get(@db, read_options, key, key.bytesize, pointerof(vallen), @errptr)
      check_error!
      String.new(val)
    end

    private def check_error!
      address = @error_slice[0].to_i
      if address != 0
        ptr = Pointer(UInt8).new(address)
        puts String.new(ptr)
        exit 1
      end
    end

  end
end
