defmodule Gleanex.Platform.Department do
  @moduledoc """
  Provides struct and type for a Department
  """

  @type t :: %__MODULE__{department_id: String.t() | nil, display_name: String.t() | nil}

  defstruct [:department_id, :display_name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [department_id: :string, display_name: :string]
  end
end
