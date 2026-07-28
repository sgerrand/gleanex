defmodule Gleanex.Indexing.GetUserCountRequest do
  @moduledoc """
  Provides struct and type for a GetUserCountRequest
  """

  @type t :: %__MODULE__{datasource: String.t()}

  defstruct [:datasource]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [datasource: :string]
  end
end
