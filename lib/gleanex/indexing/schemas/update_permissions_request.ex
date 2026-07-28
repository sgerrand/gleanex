defmodule Gleanex.Indexing.UpdatePermissionsRequest do
  @moduledoc """
  Provides struct and type for a UpdatePermissionsRequest
  """

  @type t :: %__MODULE__{
          datasource: String.t(),
          id: String.t() | nil,
          objectType: String.t() | nil,
          permissions: Gleanex.Indexing.DocumentPermissionsDefinition.t(),
          viewURL: String.t() | nil
        }

  defstruct [:datasource, :id, :objectType, :permissions, :viewURL]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      datasource: :string,
      id: :string,
      objectType: :string,
      permissions: {Gleanex.Indexing.DocumentPermissionsDefinition, :t},
      viewURL: :string
    ]
  end
end
