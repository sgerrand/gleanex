defmodule Gleanex.Client.AuthorizeActionPackRequest do
  @moduledoc """
  Provides struct and type for a AuthorizeActionPackRequest
  """

  @type t :: %__MODULE__{returnUrl: String.t()}

  defstruct [:returnUrl]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [returnUrl: :string]
  end
end
