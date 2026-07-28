defmodule Gleanex.Client.StructuredLocation do
  @moduledoc """
  Provides struct and type for a StructuredLocation
  """

  @type t :: %__MODULE__{
          address: String.t() | nil,
          city: String.t() | nil,
          country: String.t() | nil,
          countryCode: String.t() | nil,
          deskLocation: String.t() | nil,
          region: String.t() | nil,
          state: String.t() | nil,
          timezone: String.t() | nil,
          zipCode: String.t() | nil
        }

  defstruct [
    :address,
    :city,
    :country,
    :countryCode,
    :deskLocation,
    :region,
    :state,
    :timezone,
    :zipCode
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      address: :string,
      city: :string,
      country: :string,
      countryCode: :string,
      deskLocation: :string,
      region: :string,
      state: :string,
      timezone: :string,
      zipCode: :string
    ]
  end
end
