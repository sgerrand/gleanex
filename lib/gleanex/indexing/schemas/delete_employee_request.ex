defmodule Gleanex.Indexing.DeleteEmployeeRequest do
  @moduledoc """
  Provides struct and type for a DeleteEmployeeRequest
  """

  @type t :: %__MODULE__{employeeEmail: String.t(), version: integer | nil}

  defstruct [:employeeEmail, :version]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [employeeEmail: :string, version: {:integer, "int64"}]
  end
end
