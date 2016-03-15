ExUnit.start

Mix.Task.run "ecto.create", ~w(-r JanrainGuardian.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r JanrainGuardian.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(JanrainGuardian.Repo)

