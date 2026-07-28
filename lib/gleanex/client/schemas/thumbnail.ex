defmodule Gleanex.Client.Thumbnail do
  @moduledoc """
  Provides struct and type for a Thumbnail
  """

  @type t :: %__MODULE__{photoId: String.t() | nil, url: String.t() | nil}

  defstruct [:photoId, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [photoId: :string, url: :string]
  end
end
