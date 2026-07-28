defmodule Gleanex.Client.PersonTeam do
  @moduledoc """
  Provides struct and type for a PersonTeam
  """

  @type t :: %__MODULE__{
          externalLink: String.t() | nil,
          id: String.t() | nil,
          joinDate: DateTime.t() | nil,
          name: String.t() | nil,
          relationship: String.t() | nil
        }

  defstruct [:externalLink, :id, :joinDate, :name, :relationship]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      externalLink: {:string, "uri"},
      id: :string,
      joinDate: {:string, "date-time"},
      name: :string,
      relationship: {:enum, ["MEMBER", "MANAGER", "LEAD", "POINT_OF_CONTACT", "OTHER"]}
    ]
  end
end
