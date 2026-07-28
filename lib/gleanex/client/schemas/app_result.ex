defmodule Gleanex.Client.AppResult do
  @moduledoc """
  Provides struct and type for a AppResult
  """

  @type t :: %__MODULE__{
          datasource: String.t(),
          docType: String.t() | nil,
          iconUrl: String.t() | nil,
          mimeType: String.t() | nil
        }

  defstruct [:datasource, :docType, :iconUrl, :mimeType]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [datasource: :string, docType: :string, iconUrl: :string, mimeType: :string]
  end
end
