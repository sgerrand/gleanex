defmodule Gleanex.Indexing.TeamMember do
  @moduledoc """
  Provides struct and type for a TeamMember
  """

  @type t :: %__MODULE__{
          email: String.t(),
          join_date: Date.t() | nil,
          relationship: String.t() | nil
        }

  defstruct [:email, :join_date, :relationship]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [email: {:string, "email"}, join_date: {:string, "date"}, relationship: :string]
  end
end
