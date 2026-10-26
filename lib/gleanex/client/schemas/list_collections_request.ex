defmodule Gleanex.Client.ListCollectionsRequest do
  @moduledoc """
  Provides struct and type for a ListCollectionsRequest
  """

  @type t :: %__MODULE__{
          allowedDatasource: String.t() | nil,
          includeAudience: boolean | nil,
          includeRoles: boolean | nil,
          query: String.t() | nil
        }

  defstruct [:allowedDatasource, :includeAudience, :includeRoles, :query]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      allowedDatasource: :string,
      includeAudience: :boolean,
      includeRoles: :boolean,
      query: :string
    ]
  end
end
