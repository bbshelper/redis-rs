# redis-rs

[![Build Status](https://travis-ci.org/mitsuhiko/redis-rs.svg?branch=master)](https://travis-ci.org/mitsuhiko/redis-rs)

Redis-rs is a high level redis library for Rust.  It provides convenient access
to all Redis functionality through a very flexible but low-level API.  It
uses a customizable type conversion trait so that any operation can return
results in just the type you are expecting.  This makes for a very pleasant
development experience.

The crate is called `redis` and you can depend on it via cargo:

```toml
[dependencies]
redis = { git = "https://github.com/bbshelper/redis-rs", tag = "v0.10.0" }
```

Documentation on the library can be found at
[mitsuhiko.github.io/redis-rs](http://mitsuhiko.github.io/redis-rs/redis/).

## Basic Operation

To open a connection you need to create a client and then to fetch a
connection from it.  In the future there will be a connection pool for
those, currently each connection is separate and not pooled.

Many commands are implemented through the `Commands` trait but manual
command creation is also possible.

```rust
extern crate redis;
use redis::Commands;

fn fetch_an_integer() -> redis::RedisResult<isize> {
    // connect to redis
    let client = try!(redis::Client::open("redis://127.0.0.1/"));
    let con = try!(client.get_connection());
    // throw away the result, just make sure it does not fail
    let _ : () = try!(con.set("my_key", 42));
    // read back the key and return it.  Because the return value
    // from the function is a result for integer this will automatically
    // convert into one.
    con.get("my_key")
}
```

## Development

If you want to develop on the library there are a few commands provided
by the makefile:

- To build: `make`
- To test: `make test`
- To run benchmarks: `make bench`
- To build the docs: `make docs`
