defmodule Gleanex.Platform.DepartmentReference do
  @moduledoc """
  Provides struct and type for a DepartmentReference
  """

  @type t :: %__MODULE__{department_id: String.t(), display_name: String.t()}

  defstruct [:department_id, :display_name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [department_id: :string, display_name: :string]
  end
end
