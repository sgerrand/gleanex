defmodule Gleanex.Platform.SkillVersionCreateRequest do
  @moduledoc """
  Provides struct and type for a SkillVersionCreateRequest
  """

  @type t :: %__MODULE__{file: binary}

  defstruct [:file]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [file: {:string, "binary"}]
  end
end
