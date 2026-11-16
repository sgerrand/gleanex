defmodule Gleanex.Platform.TriggerAuth do
  @moduledoc """
  Provides struct and type for a TriggerAuth
  """

  @type t :: %__MODULE__{secret: String.t(), type: String.t()}

  defstruct [:secret, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [secret: :string, type: {:const, "BEARER"}]
  end
end
