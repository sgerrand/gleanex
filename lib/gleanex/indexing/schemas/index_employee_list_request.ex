defmodule Gleanex.Indexing.IndexEmployeeListRequest do
  @moduledoc """
  Provides struct and type for a IndexEmployeeListRequest
  """

  @type t :: %__MODULE__{employees: [Gleanex.Indexing.IndexEmployeeRequest.t()] | nil}

  defstruct [:employees]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [employees: [{Gleanex.Indexing.IndexEmployeeRequest, :t}]]
  end
end
