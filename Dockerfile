FROM rust as builder

# error occurred: Failed to find tool. Is `musl-gcc` installed?
# muslc is required in order to build the rust image.
RUN apt-get update && apt-get -y install ca-certificates cmake musl-tools libssl-dev && rm -rf /var/lib/apt/lists/*

COPY . .
RUN rustup target add x86_64-unknown-linux-musl
# Sets the environment variable for the cargo build command that follows.
ENV PKG_CONFIG_ALLOW_CROSS=1
RUN cargo build --target x86_64-unknown-linux-musl --release


FROM alpine
RUN apk --no-cache add ca-certificates
COPY --from=builder /target/x86_64-unknown-linux-musl/release/actix-web .
EXPOSE 8080
CMD ["/actix-web"]