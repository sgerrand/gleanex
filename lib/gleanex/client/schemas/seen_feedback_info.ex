defmodule Gleanex.Client.SeenFeedbackInfo do
  @moduledoc """
  Provides struct and type for a SeenFeedbackInfo
  """

  @type t :: %__MODULE__{isExplicit: boolean | nil}

  defstruct [:isExplicit]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [isExplicit: :boolean]
  end
end
