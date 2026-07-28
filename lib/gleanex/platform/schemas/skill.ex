defmodule Gleanex.Platform.Skill do
  @moduledoc """
  Provides struct and type for a Skill
  """

  @type t :: %__MODULE__{
          created_at: DateTime.t(),
          description: String.t(),
          display_name: String.t(),
          id: String.t(),
          latest_minor_version: integer,
          latest_version: integer,
          origin: String.t(),
          owner: Gleanex.Platform.PersonReference.t(),
          source_provenance: Gleanex.Platform.SkillSourceProvenance.t() | nil,
          status: String.t(),
          updated_at: DateTime.t()
        }

  defstruct [
    :created_at,
    :description,
    :display_name,
    :id,
    :latest_minor_version,
    :latest_version,
    :origin,
    :owner,
    :source_provenance,
    :status,
    :updated_at
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      created_at: {:string, "date-time"},
      description: :string,
      display_name: :string,
      id: :string,
      latest_minor_version: :integer,
      latest_version: :integer,
      origin: {:const, "CUSTOM"},
      owner: {Gleanex.Platform.PersonReference, :t},
      source_provenance: {Gleanex.Platform.SkillSourceProvenance, :t},
      status: {:enum, ["DRAFT", "ENABLED", "DISABLED"]},
      updated_at: {:string, "date-time"}
    ]
  end
end
