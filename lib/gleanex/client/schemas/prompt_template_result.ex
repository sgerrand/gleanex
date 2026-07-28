defmodule Gleanex.Client.PromptTemplateResult do
  @moduledoc """
  Provides struct and type for a PromptTemplateResult
  """

  @type t :: %__MODULE__{
          favoriteInfo: Gleanex.Client.FavoriteInfo.t() | nil,
          promptTemplate: Gleanex.Client.PromptTemplate.t() | nil,
          runCount: Gleanex.Client.CountInfo.t() | nil,
          trackingToken: String.t() | nil
        }

  defstruct [:favoriteInfo, :promptTemplate, :runCount, :trackingToken]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      favoriteInfo: {Gleanex.Client.FavoriteInfo, :t},
      promptTemplate: {Gleanex.Client.PromptTemplate, :t},
      runCount: {Gleanex.Client.CountInfo, :t},
      trackingToken: :string
    ]
  end
end
