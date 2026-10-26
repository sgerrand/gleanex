defmodule Gleanex.Platform.ChatCreateRequestText do
  @moduledoc """
  Provides struct and type for a ChatCreateRequestText
  """

  @type t :: %__MODULE__{
          format:
            Gleanex.Platform.ChatJsonSchemaFormat.t() | Gleanex.Platform.ChatTextFormat.t() | nil
        }

  defstruct [:format]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      format:
        {:union,
         [{Gleanex.Platform.ChatJsonSchemaFormat, :t}, {Gleanex.Platform.ChatTextFormat, :t}]}
    ]
  end
end
