defmodule Gleanex.Admin.HotwordProximity do
  @moduledoc """
  Provides struct and type for a HotwordProximity
  """

  @type t :: %__MODULE__{windowAfter: integer | nil, windowBefore: integer | nil}

  defstruct [:windowAfter, :windowBefore]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [windowAfter: :integer, windowBefore: :integer]
  end
end
