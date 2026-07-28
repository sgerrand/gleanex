defmodule Gleanex.Client.GetCollectionRequest do
  @moduledoc """
  Provides struct and type for a GetCollectionRequest
  """

  @type t :: %__MODULE__{
          allowedDatasource: String.t() | nil,
          id: integer,
          withHierarchy: boolean | nil,
          withItems: boolean | nil
        }

  defstruct [:allowedDatasource, :id, :withHierarchy, :withItems]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [allowedDatasource: :string, id: :integer, withHierarchy: :boolean, withItems: :boolean]
  end
end
