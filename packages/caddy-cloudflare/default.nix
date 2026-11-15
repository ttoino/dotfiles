{ caddy, sources, ... }:

caddy.withPlugins {
  plugins = [ "github.com/caddy-dns/cloudflare@${sources.caddy-cloudflare.version}" ];
  hash = "sha256-QSiwKqKvSxhksWBF4/MlBOpyXba5xOQ2sRwA0R7399E=";
}
