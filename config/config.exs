# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :janrain_guardian, JanrainGuardian.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "TIhYLC73LtukaUntdTmwppoVSpVfCztfClvebActwrGCyDJXGCZ6utEqRuKzpIZ/",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: JanrainGuardian.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :guardian, Guardian,
  issuer: "JanrainGuardian",
  ttl: { 30, :days },
  secret_key: "eb90ad5a55582700b01639a3c608e43b5487627a",
  serializer: JanrainGuardian.GuardianSerializer
