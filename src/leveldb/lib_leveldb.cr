@[Link("leveldb")]
lib LibLevelDB
  alias SizeT = UInt64

  enum Compression
    NO_COMPORESSEION
    SNAPPY_COMPRESSION
  end

  # DB
  fun leveldb_open(options : Void*, name : UInt8*,  errptr : Void*) : Void*
  fun leveldb_put(db : Void*, woptions : Void*, key : UInt8*, keylen : UInt64, val : UInt8*, vallen : UInt64, errptr : Void*) : Void
  fun leveldb_get(db : Void*, roptions : Void*, key : UInt8*, keylen : UInt64, vallen : UInt64*, errptr : Void*) : UInt8*
  fun leveldb_delete(db : Void*, woptions : Void*, key : UInt8*, keylen : UInt64, errptr : Void*) : Void
  fun leveldb_close(db : Void*)
  fun leveldb_destroy_db(options : Void*, name : UInt8*, errptr : Void*)

  # Options
  fun leveldb_options_create() : Void*
  fun leveldb_options_set_create_if_missing(options : Void*, val : Bool)
  fun leveldb_options_set_compression(options : Void*, val : Compression)
  fun leveldb_writeoptions_create() : Void*
  fun leveldb_readoptions_create() : Void*

  # Snapshot
  fun leveldb_create_snapshot(db : Void*) : Void*
  fun leveldb_readoptions_set_snapshot(roptions : Void*, snapshot : Void*)
  fun leveldb_release_snapshot(db : Void*, snapshot : Void*)

  # Iterator
  fun leveldb_create_iterator(db : Void*, roptions : Void*) : Void*
  fun leveldb_iter_destroy(iterator : Void *);
  fun leveldb_iter_next(iterator : Void*)
  fun leveldb_iter_key(iterator : Void*, klen : SizeT*) : UInt8*
  fun leveldb_iter_value(iterator : Void*, vlen : SizeT*) : UInt8*
  fun leveldb_iter_get_error(iterator : Void*, errptr : Void*)
  fun leveldb_iter_seek_to_first(iterator : Void*)
  fun leveldb_iter_seek_to_last(iterator : Void*)
  fun leveldb_iter_seek(iterator : Void*, key : UInt8*, klen : SizeT);
  fun leveldb_iter_valid(iterator : Void*) : Bool

  # Misc
  fun leveldb_free(ptr : Void*)
end
