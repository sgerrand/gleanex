defmodule Gleanex.Client.ChatCitationAnnotation do
  @moduledoc """
  Provides struct and type for a ChatCitationAnnotation
  """

  @type t :: %__MODULE__{
          end_index: integer | nil,
          snippets: [Gleanex.Client.ChatCitationSnippet.t()] | nil,
          sources: [
            map
            | Gleanex.Client.ChatCustomEntitySource.t()
            | Gleanex.Client.ChatFileSource.t()
            | Gleanex.Client.ChatPersonSource.t()
          ],
          start_index: integer | nil,
          type: String.t()
        }

  defstruct [:end_index, :snippets, :sources, :start_index, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      end_index: :integer,
      snippets: [{Gleanex.Client.ChatCitationSnippet, :t}],
      sources: [
        union: [
          :map,
          {Gleanex.Client.ChatCustomEntitySource, :t},
          {Gleanex.Client.ChatFileSource, :t},
          {Gleanex.Client.ChatPersonSource, :t}
        ]
      ],
      start_index: :integer,
      type: {:const, "CITATION"}
    ]
  end
end
