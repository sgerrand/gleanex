defmodule Gleanex.Platform.GetDepartmentResponse do
  @moduledoc """
  Provides struct and type for a GetDepartmentResponse
  """

  @type t :: %__MODULE__{department: Gleanex.Platform.Department.t(), request_id: String.t()}

  defstruct [:department, :request_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [department: {Gleanex.Platform.Department, :t}, request_id: :string]
  end
end
