defmodule Gleanex.Platform.ChatOutputTextContent do
  @moduledoc """
  Provides struct and type for a ChatOutputTextContent
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
      type: {:const, "output_text"}
    ]
  end
end
