defmodule Gleanex.Admin.CustomSensitiveRule do
  @moduledoc """
  Provides struct and type for a CustomSensitiveRule
  """

  @type t :: %__MODULE__{
          id: String.t() | nil,
          likelihoodThreshold: String.t() | nil,
          type: String.t() | nil,
          value: String.t() | nil
        }

  defstruct [:id, :likelihoodThreshold, :type, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      id: :string,
      likelihoodThreshold:
        {:enum, ["LIKELY", "VERY_LIKELY", "POSSIBLE", "UNLIKELY", "VERY_UNLIKELY"]},
      type: {:enum, ["REGEX", "TERM", "INFO_TYPE"]},
      value: :string
    ]
  end
end
