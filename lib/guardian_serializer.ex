defmodule JanrainGuardian.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias JanrainGuardian.Repo
  alias JanrainGuardian.User

  def for_token(identity), do: { :ok, "identity:#{identity}" }

  def from_token("identity:" <> identity), do: { :ok, Repo.get_by(User, identity: identity) }
end
