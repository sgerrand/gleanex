defmodule Gleanex.Platform.DocumentContent do
  @moduledoc """
  Provides struct and type for a DocumentContent
  """

  @type t :: %__MODULE__{full_text_list: [String.t()]}

  defstruct [:full_text_list]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [full_text_list: [:string]]
  end
end
