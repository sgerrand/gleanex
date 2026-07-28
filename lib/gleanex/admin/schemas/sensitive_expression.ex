defmodule Gleanex.Admin.SensitiveExpression do
  @moduledoc """
  Provides struct and type for a SensitiveExpression
  """

  @type t :: %__MODULE__{
          expression: String.t() | nil,
          hotwords: [Gleanex.Admin.Hotword.t()] | nil
        }

  defstruct [:expression, :hotwords]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [expression: :string, hotwords: [{Gleanex.Admin.Hotword, :t}]]
  end
end
