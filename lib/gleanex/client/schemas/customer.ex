defmodule Gleanex.Client.Customer do
  @moduledoc """
  Provides struct and type for a Customer
  """

  @type t :: %__MODULE__{
          company: Gleanex.Client.Company.t(),
          contractAnnualRevenue: number | nil,
          documentCounts: map | nil,
          domains: [String.t()] | nil,
          id: String.t(),
          mergedCustomers: [Gleanex.Client.Customer.t()] | nil,
          metadata: Gleanex.Client.CustomerMetadata.t() | nil,
          notes: String.t() | nil,
          poc: [Gleanex.Client.Person.t()] | nil,
          startDate: Date.t() | nil
        }

  defstruct [
    :company,
    :contractAnnualRevenue,
    :documentCounts,
    :domains,
    :id,
    :mergedCustomers,
    :metadata,
    :notes,
    :poc,
    :startDate
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      company: {Gleanex.Client.Company, :t},
      contractAnnualRevenue: {:number, "double"},
      documentCounts: :map,
      domains: [:string],
      id: :string,
      mergedCustomers: [{Gleanex.Client.Customer, :t}],
      metadata: {Gleanex.Client.CustomerMetadata, :t},
      notes: :string,
      poc: [{Gleanex.Client.Person, :t}],
      startDate: {:string, "date"}
    ]
  end
end
