defmodule Gleanex.Platform.DatasourceFilterInfo do
  @moduledoc """
  Provides struct and type for a DatasourceFilterInfo
  """

  @type t :: %__MODULE__{datasource: String.t(), filters: [Gleanex.Platform.FilterFieldInfo.t()]}

  defstruct [:datasource, :filters]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [datasource: :string, filters: [{Gleanex.Platform.FilterFieldInfo, :t}]]
  end
end
