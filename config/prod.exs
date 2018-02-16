use Mix.Config

# For production, we often load configuration from external
# sources, such as your system environment. For this reason,
# you won't find the :http configuration below, but set inside
# Admin.Endpoint.init/2 when load_from_system_env is
# true. Any dynamic configuration should be done there.
#
# Don't forget to configure the url host to something meaningful,
# Phoenix uses this information when generating URLs.
#
# Finally, we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the mix phx.digest task
# which you typically run after static files are built.
config :admin, Admin.Endpoint,
  load_from_system_env: true,
  check_origin: [
    "https://admin.justicedemocrats.com",
    "https://esm.betofortexas.com",
    "https://beto-esm.gigalixirapp.com"
  ],
  url: [host: "turnout.justicedemocrats.com", port: 4000],
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true

# Do not print debug messages in production
config :logger, level: :info

config :admin, script_tag: ~s(/js/)

config :admin,
  css_tag:
    ~s(<link rel="stylesheet" type="text/css" href="/css/app.css" media="screen,projection" />)

# ## SSL Support
#
# To get SSL working, you will need to add the `https` key
# to the previous section and set your `:url` port to 443:
#
#     config :admin, Admin.Endpoint,
#       ...
#       url: [host: "example.com", port: 443],
#       https: [:inet6,
#               port: 443,
#               keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#               certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables return an absolute path to
# the key and cert in disk or a relative path inside priv,
# for example "priv/ssl/server.key".
#
# We also recommend setting `force_ssl`, ensuring no data is
# ever sent via http, always redirecting to https:
#
#     config :admin, Admin.Endpoint,
#       force_ssl: [hsts: true]
#
# Check `Plug.SSL` for all available options in `force_ssl`.

# ## Using releases
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start the server for all endpoints:
#
#     config :phoenix, :serve_endpoints, true
#
# Alternatively, you can configure exactly which server to
# start per endpoint:
#
#     config :admin, Admin.Endpoint, server: true
#

# Finally import the config/prod.secret.exs
# which should be versioned separately.

config :ueberauth, Ueberauth,
  providers: [
    google: {
      Ueberauth.Strategy.Google,
      [
        approval_prompt: "force",
        access_type: "offline",
        default_scope: "email profile"
      ]
    }
  ]

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: "${GOOGLE_CLIENT_ID}",
  client_secret: "${GOOGLE_CLIENT_SECRET}"

# Cipher
config :cipher,
  keyphrase: "${CIPHER_KEYPHRASE}",
  ivphrase: "${CIPHER_IVPHRASE}"

# Proxy layer + mongo
config :admin,
  proxy_base_url: "${PROXY_BASE_URL}",
  proxy_secret: "${PROXY_SECRET}",
  mongodb_username: "${MONGO_USERNAME}",
  mongodb_hostname: "${MONGO_HOSTNAME}",
  mongodb_password: "${MONGO_PASSWORD}",
  mongodb_port: "${MONGO_PORT}",
  deployed_url: "${DEPLOYED_URL}"

config :actionkit,
  base: "${AK_BASE}",
  username: "${AK_USERNAME}",
  password: "${AK_PASSWORD}"

config :rollbax,
  access_token: "${ROLLBAR_TOKEN}",
  environment: "production"

config :maps, key: "${MAPS_KEY}"
