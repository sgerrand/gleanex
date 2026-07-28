defmodule Gleanex.Platform.SkillVersionCreateResponse do
  @moduledoc """
  Provides struct and type for a SkillVersionCreateResponse
  """

  @type t :: %__MODULE__{request_id: String.t(), version: Gleanex.Platform.SkillVersion.t()}

  defstruct [:request_id, :version]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [request_id: :string, version: {Gleanex.Platform.SkillVersion, :t}]
  end
end
