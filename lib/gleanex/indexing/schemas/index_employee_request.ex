defmodule Gleanex.Indexing.IndexEmployeeRequest do
  @moduledoc """
  Provides struct and type for a IndexEmployeeRequest
  """

  @type t :: %__MODULE__{
          employee: Gleanex.Indexing.EmployeeInfoDefinition.t(),
          version: integer | nil
        }

  defstruct [:employee, :version]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [employee: {Gleanex.Indexing.EmployeeInfoDefinition, :t}, version: {:integer, "int64"}]
  end
end
