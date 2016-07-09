@[Link("leveldb")]
lib LibLevelDB
  enum Compression
    NO_COMPORESSEION
    SNAPPY_COMPRESSION
  end

  fun leveldb_open(options : Void*, name : UInt8*,  errptr : Void*) : Void*

  fun leveldb_options_create() : Void*

  fun leveldb_writeoptions_create() : Void*

  fun leveldb_put(db : Void*, woptions : Void*, key : UInt8*, keylen : UInt64, val : UInt8*, vallen : UInt64, errptr : Void*) : Void

  fun leveldb_options_set_create_if_missing(options : Void*, val : Bool)

  fun leveldb_options_set_compression(options : Void*, val : Compression);

  fun leveldb_readoptions_create() : Void*

  fun leveldb_get(db : Void*, roptions : Void*, key : UInt8*, keylen : UInt64, vallen : UInt64*, errptr : Void*) : UInt8*

  fun leveldb_delete(db : Void*, woptions : Void*, key : UInt8*, keylen : UInt64, errptr : Void*) : Void

  fun leveldb_free(ptr : Void*)

  fun leveldb_close(db : Void*)

  fun leveldb_destroy_db(options : Void*, name : UInt8*, errptr : Void*)

  fun leveldb_create_snapshot(db : Void*) : Void*

  fun leveldb_readoptions_set_snapshot(roptions : Void*, snapshot : Void*)

  fun leveldb_release_snapshot(db : Void*, snapshot : Void*)
end
