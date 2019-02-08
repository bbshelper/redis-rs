build:
	@cargo build

test:
	@echo "Testing Connection Type TCP"
	@REDISRS_SERVER_TYPE=tcp RUST_TEST_THREADS=1 cargo test
	@echo "Testing Connection Type UNIX SOCKETS"
	@REDISRS_SERVER_TYPE=unix cargo test --features="uds"

test-single: RUST_TEST_THREADS=1
test-single: test

bench:
	@RUST_TEST_THREADS=1 cargo bench

docs: build
	@cargo doc --no-deps

upload-docs: docs
	@./upload-docs.sh

.PHONY: build test bench docs upload-docs
