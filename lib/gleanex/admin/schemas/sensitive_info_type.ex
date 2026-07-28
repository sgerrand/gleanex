defmodule Gleanex.Admin.SensitiveInfoType do
  @moduledoc """
  Provides struct and type for a SensitiveInfoType
  """

  @type t :: %__MODULE__{infoType: String.t() | nil, likelihoodThreshold: String.t() | nil}

  defstruct [:infoType, :likelihoodThreshold]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      infoType: :string,
      likelihoodThreshold:
        {:enum, ["LIKELY", "VERY_LIKELY", "POSSIBLE", "UNLIKELY", "VERY_UNLIKELY"]}
    ]
  end
end
