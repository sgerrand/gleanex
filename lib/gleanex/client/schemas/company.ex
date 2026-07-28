defmodule Gleanex.Client.Company do
  @moduledoc """
  Provides struct and type for a Company
  """

  @type t :: %__MODULE__{
          about: String.t() | nil,
          annualRevenue: number | nil,
          fax: String.t() | nil,
          foundedDate: Date.t() | nil,
          industry: String.t() | nil,
          location: String.t() | nil,
          logoUrl: String.t() | nil,
          name: String.t(),
          numberOfEmployees: integer | nil,
          phone: String.t() | nil,
          profileUrl: String.t() | nil,
          stockSymbol: String.t() | nil,
          websiteUrls: [String.t()] | nil
        }

  defstruct [
    :about,
    :annualRevenue,
    :fax,
    :foundedDate,
    :industry,
    :location,
    :logoUrl,
    :name,
    :numberOfEmployees,
    :phone,
    :profileUrl,
    :stockSymbol,
    :websiteUrls
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      about: :string,
      annualRevenue: {:number, "double"},
      fax: :string,
      foundedDate: {:string, "date"},
      industry: :string,
      location: :string,
      logoUrl: :string,
      name: :string,
      numberOfEmployees: {:integer, "int64"},
      phone: :string,
      profileUrl: :string,
      stockSymbol: :string,
      websiteUrls: [:string]
    ]
  end
end
