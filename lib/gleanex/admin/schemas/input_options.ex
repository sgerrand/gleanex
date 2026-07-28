defmodule Gleanex.Admin.InputOptions do
  @moduledoc """
  Provides struct and type for a InputOptions
  """

  @type t :: %__MODULE__{
          customTimeRange: Gleanex.Admin.TimeRange.t() | nil,
          datasourceInstances: [String.t()] | nil,
          datasources: [String.t()] | nil,
          datasourcesType: String.t() | nil,
          subsetDocIdsToScan: [String.t()] | nil,
          timePeriodType: String.t() | nil,
          urlGreenlist: [String.t()] | nil
        }

  defstruct [
    :customTimeRange,
    :datasourceInstances,
    :datasources,
    :datasourcesType,
    :subsetDocIdsToScan,
    :timePeriodType,
    :urlGreenlist
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      customTimeRange: {Gleanex.Admin.TimeRange, :t},
      datasourceInstances: [:string],
      datasources: [:string],
      datasourcesType: {:enum, ["ALL", "CUSTOM"]},
      subsetDocIdsToScan: [:string],
      timePeriodType: {:enum, ["ALL_TIME", "PAST_YEAR", "PAST_DAY", "CUSTOM", "LAST_N_DAYS"]},
      urlGreenlist: [:string]
    ]
  end
end
