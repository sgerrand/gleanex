defmodule Gleanex.Client.PersonToTeamRelationship do
  @moduledoc """
  Provides struct and type for a PersonToTeamRelationship
  """

  @type t :: %__MODULE__{
          customRelationshipStr: String.t() | nil,
          joinDate: DateTime.t() | nil,
          person: Gleanex.Client.Person.t(),
          relationship: String.t() | nil
        }

  defstruct [:customRelationshipStr, :joinDate, :person, :relationship]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      customRelationshipStr: :string,
      joinDate: {:string, "date-time"},
      person: {Gleanex.Client.Person, :t},
      relationship: {:enum, ["MEMBER", "MANAGER", "LEAD", "POINT_OF_CONTACT", "OTHER"]}
    ]
  end
end
