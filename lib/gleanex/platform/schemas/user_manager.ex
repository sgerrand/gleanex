defmodule Gleanex.Platform.UserManager do
  @moduledoc """
  Provides struct and type for a UserManager
  """

  @type t :: %__MODULE__{display_name: String.t(), user_id: String.t()}

  defstruct [:display_name, :user_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [display_name: :string, user_id: :string]
  end
end
