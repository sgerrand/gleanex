defmodule Gleanex.Client.User do
  @moduledoc """
  Provides struct and type for a User
  """

  @type t :: %__MODULE__{origID: String.t() | nil, userID: String.t() | nil}

  defstruct [:origID, :userID]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [origID: :string, userID: :string]
  end
end
