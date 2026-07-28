defmodule Gleanex.Client.ActivityEventParams do
  @moduledoc """
  Provides struct and type for a ActivityEventParams
  """

  @type t :: %__MODULE__{
          bodyContent: String.t() | nil,
          datasource: String.t() | nil,
          datasourceInstance: String.t() | nil,
          duration: integer | nil,
          instanceOnlyName: String.t() | nil,
          query: String.t() | nil,
          referrer: String.t() | nil,
          title: String.t() | nil,
          truncated: boolean | nil
        }

  defstruct [
    :bodyContent,
    :datasource,
    :datasourceInstance,
    :duration,
    :instanceOnlyName,
    :query,
    :referrer,
    :title,
    :truncated
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      bodyContent: :string,
      datasource: :string,
      datasourceInstance: :string,
      duration: :integer,
      instanceOnlyName: :string,
      query: :string,
      referrer: :string,
      title: :string,
      truncated: :boolean
    ]
  end
end
