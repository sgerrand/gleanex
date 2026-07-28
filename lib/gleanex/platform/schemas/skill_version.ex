defmodule Gleanex.Platform.SkillVersion do
  @moduledoc """
  Provides struct and type for a SkillVersion
  """

  @type t :: %__MODULE__{
          created_at: DateTime.t(),
          created_by: Gleanex.Platform.PersonReference.t(),
          is_latest: boolean,
          minor_version: integer,
          skill_id: String.t(),
          source_provenance: Gleanex.Platform.SkillSourceProvenance.t() | nil,
          updated_at: DateTime.t(),
          version: integer
        }

  defstruct [
    :created_at,
    :created_by,
    :is_latest,
    :minor_version,
    :skill_id,
    :source_provenance,
    :updated_at,
    :version
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      created_at: {:string, "date-time"},
      created_by: {Gleanex.Platform.PersonReference, :t},
      is_latest: :boolean,
      minor_version: :integer,
      skill_id: :string,
      source_provenance: {Gleanex.Platform.SkillSourceProvenance, :t},
      updated_at: {:string, "date-time"},
      version: :integer
    ]
  end
end
