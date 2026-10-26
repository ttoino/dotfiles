{ caddy, sources, ... }:

caddy.withPlugins {
  plugins = [ "github.com/caddy-dns/cloudflare@${sources.caddy-cloudflare.version}" ];
  hash = "sha256-tubXIDCJnO2mvdnPlZclwDhNGaeeYLSt7lnni3+pXDo=";
}
