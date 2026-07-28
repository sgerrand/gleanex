defmodule Gleanex.Client.UserRoleSpecification do
  @moduledoc """
  Provides struct and type for a UserRoleSpecification
  """

  @type t :: %__MODULE__{
          group: Gleanex.Client.Group.t() | nil,
          person: Gleanex.Client.Person.t() | nil,
          role: String.t(),
          sourceDocumentSpec: map | nil
        }

  defstruct [:group, :person, :role, :sourceDocumentSpec]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      group: {Gleanex.Client.Group, :t},
      person: {Gleanex.Client.Person, :t},
      role: {:enum, ["OWNER", "VIEWER", "ANSWER_MODERATOR", "EDITOR", "VERIFIER"]},
      sourceDocumentSpec: :map
    ]
  end
end
