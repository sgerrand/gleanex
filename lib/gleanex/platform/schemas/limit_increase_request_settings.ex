defmodule Gleanex.Platform.LimitIncreaseRequestSettings do
  @moduledoc """
  Provides struct and type for a LimitIncreaseRequestSettings
  """

  @type t :: %__MODULE__{business_justification: String.t()}

  defstruct [:business_justification]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [business_justification: {:enum, ["OPTIONAL", "REQUIRED"]}]
  end
end
