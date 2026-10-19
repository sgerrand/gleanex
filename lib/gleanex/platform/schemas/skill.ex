defmodule Gleanex.Platform.Skill do
  @moduledoc """
  Provides struct and type for a Skill
  """

  @type t :: %__MODULE__{
          created_at: DateTime.t(),
          description: String.t(),
          display_name: String.t(),
          latest_minor_version: integer,
          latest_version: integer,
          origin: String.t(),
          owner: Gleanex.Platform.PersonReference.t(),
          skill_id: String.t(),
          source_provenance: Gleanex.Platform.SkillSourceProvenance.t() | nil,
          status: String.t(),
          updated_at: DateTime.t()
        }

  defstruct [
    :created_at,
    :description,
    :display_name,
    :latest_minor_version,
    :latest_version,
    :origin,
    :owner,
    :skill_id,
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
      latest_minor_version: :integer,
      latest_version: :integer,
      origin: {:enum, ["CUSTOM", "GITHUB"]},
      owner: {Gleanex.Platform.PersonReference, :t},
      skill_id: :string,
      source_provenance: {Gleanex.Platform.SkillSourceProvenance, :t},
      status: {:enum, ["DRAFT", "ENABLED", "DISABLED"]},
      updated_at: {:string, "date-time"}
    ]
  end
end
