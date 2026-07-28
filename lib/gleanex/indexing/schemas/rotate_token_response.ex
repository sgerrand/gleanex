defmodule Gleanex.Indexing.RotateTokenResponse do
  @moduledoc """
  Provides struct and type for a RotateTokenResponse
  """

  @type t :: %__MODULE__{
          createdAt: integer | nil,
          rawSecret: String.t() | nil,
          rotationPeriodMinutes: integer | nil
        }

  defstruct [:createdAt, :rawSecret, :rotationPeriodMinutes]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      createdAt: {:integer, "int64"},
      rawSecret: :string,
      rotationPeriodMinutes: {:integer, "int64"}
    ]
  end
end
