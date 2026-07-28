defmodule Gleanex.Platform.SkillsListResponse do
  @moduledoc """
  Provides struct and type for a SkillsListResponse
  """

  @type t :: %__MODULE__{
          has_more: boolean,
          next_cursor: String.t() | nil,
          request_id: String.t(),
          skills: [Gleanex.Platform.Skill.t()]
        }

  defstruct [:has_more, :next_cursor, :request_id, :skills]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      has_more: :boolean,
      next_cursor: :string,
      request_id: :string,
      skills: [{Gleanex.Platform.Skill, :t}]
    ]
  end
end
