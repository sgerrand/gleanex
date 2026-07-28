defmodule Gleanex.Client.DeleteCollectionRequest do
  @moduledoc """
  Provides struct and type for a DeleteCollectionRequest
  """

  @type t :: %__MODULE__{allowedDatasource: String.t() | nil, ids: [integer]}

  defstruct [:allowedDatasource, :ids]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [allowedDatasource: :string, ids: [:integer]]
  end
end
