defmodule Gleanex.Client.DigestUpdate do
  @moduledoc """
  Provides struct and type for a DigestUpdate
  """

  @type t :: %__MODULE__{
          datasource: String.t() | nil,
          summary: String.t() | nil,
          title: String.t() | nil,
          type: String.t() | nil,
          url: String.t() | nil,
          urls: [String.t()] | nil
        }

  defstruct [:datasource, :summary, :title, :type, :url, :urls]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      datasource: :string,
      summary: :string,
      title: :string,
      type: {:enum, ["ACTIONABLE", "INFORMATIVE"]},
      url: :string,
      urls: [:string]
    ]
  end
end
