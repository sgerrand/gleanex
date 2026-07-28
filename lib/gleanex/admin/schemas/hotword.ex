defmodule Gleanex.Admin.Hotword do
  @moduledoc """
  Provides struct and type for a Hotword
  """

  @type t :: %__MODULE__{
          proximity: Gleanex.Admin.HotwordProximity.t() | nil,
          regex: String.t() | nil
        }

  defstruct [:proximity, :regex]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [proximity: {Gleanex.Admin.HotwordProximity, :t}, regex: :string]
  end
end
