@[Link("leveldb")]
lib LibLevelDB
  #fun leveldb_open(UInt32) : Void*
  fun leveldb_open(options : Void*, name : UInt8*,  err : Void*) : Void*

  fun leveldb_options_create() : Void*

  fun leveldb_writeoptions_create() : Void*

  fun leveldb_put(db : Void*, woptions : Void*, key : UInt8*, keylen : UInt64, val : UInt8*, vallen : UInt64, errptr : Void*) : Void

  fun leveldb_options_set_create_if_missing(options : Void*, val : UInt8)

  fun leveldb_readoptions_create() : Void*

  fun leveldb_get(db : Void*, roptions : Void*, key : UInt8*, keylen : UInt64, vallen : UInt64*, errptr : Void*) : UInt8*

    #leveldb_get(db, roptions, "key", 3, &read_len, &err);
end
