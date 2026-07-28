defmodule Gleanex.Indexing.DeleteMembershipRequest do
  @moduledoc """
  Provides struct and type for a DeleteMembershipRequest
  """

  @type t :: %__MODULE__{
          datasource: String.t(),
          membership: Gleanex.Indexing.DatasourceMembershipDefinition.t(),
          version: integer | nil
        }

  defstruct [:datasource, :membership, :version]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      datasource: :string,
      membership: {Gleanex.Indexing.DatasourceMembershipDefinition, :t},
      version: {:integer, "int64"}
    ]
  end
end
