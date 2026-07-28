defmodule Gleanex.Indexing.DatasourceProfile do
  @moduledoc """
  Provides struct and type for a DatasourceProfile
  """

  @type t :: %__MODULE__{
          datasource: String.t(),
          handle: String.t(),
          isUserGenerated: boolean | nil,
          nativeAppUrl: String.t() | nil,
          url: String.t() | nil
        }

  defstruct [:datasource, :handle, :isUserGenerated, :nativeAppUrl, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      datasource: :string,
      handle: :string,
      isUserGenerated: :boolean,
      nativeAppUrl: :string,
      url: :string
    ]
  end
end
