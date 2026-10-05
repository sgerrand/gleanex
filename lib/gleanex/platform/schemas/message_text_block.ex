defmodule Gleanex.Platform.MessageTextBlock do
  @moduledoc """
  Provides struct and type for a MessageTextBlock
  """

  @type t :: %__MODULE__{
          annotations: [Gleanex.Platform.ChatCitationAnnotation.t()] | nil,
          text: String.t(),
          type: String.t()
        }

  defstruct [:annotations, :text, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      annotations: [{Gleanex.Platform.ChatCitationAnnotation, :t}],
      text: :string,
      type: {:const, "text"}
    ]
  end
end
