use futures::IntoFuture;

use actix_web::{
    get, middleware, web, App, Error, HttpRequest, HttpResponse, HttpServer,
};

#[get("/")]
fn no_params() -> &'static str {
    "Hello world!\r\n"
}

fn main() -> std::io::Result<()> {
    std::env::set_var("RUST_LOG", "actix_server=info,actix_web=info");
    env_logger::init();

    HttpServer::new(|| {
        App::new()
            .service(no_params)
    })
    .bind("127.0.0.1:8080")?
    .workers(1)
    .run()
}