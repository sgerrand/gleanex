defmodule Gleanex.Indexing.DatasourceBulkMembershipDefinition do
  @moduledoc """
  Provides struct and type for a DatasourceBulkMembershipDefinition
  """

  @type t :: %__MODULE__{memberGroupName: String.t() | nil, memberUserId: String.t() | nil}

  defstruct [:memberGroupName, :memberUserId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [memberGroupName: :string, memberUserId: :string]
  end
end
