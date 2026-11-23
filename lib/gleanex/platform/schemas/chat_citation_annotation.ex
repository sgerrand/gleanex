defmodule Gleanex.Platform.ChatCitationAnnotation do
  @moduledoc """
  Provides struct and type for a ChatCitationAnnotation
  """

  @type t :: %__MODULE__{
          end_index: integer | nil,
          snippets: [map] | nil,
          sources: [
            map
            | Gleanex.Platform.ChatCustomEntitySource.t()
            | Gleanex.Platform.ChatFileSource.t()
            | Gleanex.Platform.ChatPersonSource.t()
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
      end_index: {:union, [:integer, :null]},
      snippets: {:union, [[:map], :null]},
      sources: [
        union: [
          :map,
          {Gleanex.Platform.ChatCustomEntitySource, :t},
          {Gleanex.Platform.ChatFileSource, :t},
          {Gleanex.Platform.ChatPersonSource, :t}
        ]
      ],
      start_index: {:union, [:integer, :null]},
      type: {:const, "CITATION"}
    ]
  end
end
