defmodule Gleanex.Platform.SkillVersionsListResponse do
  @moduledoc """
  Provides struct and type for a SkillVersionsListResponse
  """

  @type t :: %__MODULE__{
          has_more: boolean,
          next_cursor: String.t() | nil,
          request_id: String.t(),
          versions: [Gleanex.Platform.SkillVersion.t()]
        }

  defstruct [:has_more, :next_cursor, :request_id, :versions]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      has_more: :boolean,
      next_cursor: :string,
      request_id: :string,
      versions: [{Gleanex.Platform.SkillVersion, :t}]
    ]
  end
end
