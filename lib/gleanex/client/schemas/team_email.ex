defmodule Gleanex.Client.TeamEmail do
  @moduledoc """
  Provides struct and type for a TeamEmail
  """

  @type t :: %__MODULE__{
          email: String.t() | nil,
          isUserGenerated: boolean | nil,
          type: String.t() | nil
        }

  defstruct [:email, :isUserGenerated, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      email: {:string, "email"},
      isUserGenerated: :boolean,
      type: {:enum, ["PRIMARY", "SECONDARY", "ONCALL", "OTHER"]}
    ]
  end
end
