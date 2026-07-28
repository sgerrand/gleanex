defmodule Gleanex.Indexing.DatasourceMembershipDefinition do
  @moduledoc """
  Provides struct and type for a DatasourceMembershipDefinition
  """

  @type t :: %__MODULE__{
          groupName: String.t(),
          memberGroupName: String.t() | nil,
          memberUserId: String.t() | nil
        }

  defstruct [:groupName, :memberGroupName, :memberUserId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [groupName: :string, memberGroupName: :string, memberUserId: :string]
  end
end
