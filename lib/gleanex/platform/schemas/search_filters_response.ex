defmodule Gleanex.Platform.SearchFiltersResponse do
  @moduledoc """
  Provides struct and type for a SearchFiltersResponse
  """

  @type t :: %__MODULE__{
          datasources: [Gleanex.Platform.DatasourceFilterInfo.t()],
          request_id: String.t()
        }

  defstruct [:datasources, :request_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [datasources: [{Gleanex.Platform.DatasourceFilterInfo, :t}], request_id: :string]
  end
end
