defmodule Gleanex.Client.ToolSets do
  @moduledoc """
  Provides struct and type for a ToolSets
  """

  @type t :: %__MODULE__{enableCompanyTools: boolean | nil, enableWebSearch: boolean | nil}

  defstruct [:enableCompanyTools, :enableWebSearch]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [enableCompanyTools: :boolean, enableWebSearch: :boolean]
  end
end
