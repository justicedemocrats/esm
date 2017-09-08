use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :admin, Admin.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: ["node_modules/.bin/webpack-dev-server", "--inline", "--colors", "--hot", "--stdin", "--host", "localhost", "--port", "8080", "--public", "localhost:8080",
    cd: Path.expand("../assets", __DIR__)
  ]]

config :osdi, Osdi.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "osdi_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  types: GeoExample.PostgresTypes


config :ueberauth, Ueberauth,
  providers: [
    google: {Ueberauth.Strategy.Google, [
        approval_prompt: "force",
        access_type: "offline",
        default_scope: "email profile",
        hd: System.get_env("HOSTED_DOMAIN"),
      ]}
  ]

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET")

# ## SSL Support
#
# In order to use HTTPS in development, a self-signed
# certificate can be generated by running the following
# command from your terminal:
#
#     openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" -keyout priv/server.key -out priv/server.pem
#
# The `http:` config above can be replaced with:
#
#     https: [port: 4000, keyfile: "priv/server.key", certfile: "priv/server.pem"],
#
# If desired, both `http:` and `https:` keys can be
# configured to run both http and https servers on
# different ports.

# Watch static and templates for browser reloading.
config :admin, Admin.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/admin_web/views/.*(ex)$},
      ~r{lib/admin_web/templates/.*(eex)$},
      ~r{lib/admin_web/channels/.*(ex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20
