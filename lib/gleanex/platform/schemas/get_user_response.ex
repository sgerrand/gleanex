defmodule Gleanex.Platform.GetUserResponse do
  @moduledoc """
  Provides struct and type for a GetUserResponse
  """

  @type t :: %__MODULE__{request_id: String.t(), user: Gleanex.Platform.User.t()}

  defstruct [:request_id, :user]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [request_id: :string, user: {Gleanex.Platform.User, :t}]
  end
end
