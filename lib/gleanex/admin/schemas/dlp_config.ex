defmodule Gleanex.Admin.DlpConfig do
  @moduledoc """
  Provides struct and type for a DlpConfig
  """

  @type t :: %__MODULE__{
          allowlistOptions: Gleanex.Admin.AllowlistOptions.t() | nil,
          autoHideDocs: boolean | nil,
          broadSharingOptions: Gleanex.Admin.SharingOptions.t() | nil,
          createdAt: String.t() | nil,
          createdBy: Gleanex.Admin.DlpPerson.t() | nil,
          externalSharingOptions: Gleanex.Admin.ExternalSharingOptions.t() | nil,
          frequency: String.t() | nil,
          inputOptions: Gleanex.Admin.InputOptions.t() | nil,
          redactQuote: boolean | nil,
          reportName: String.t() | nil,
          sensitiveContentOptions: Gleanex.Admin.SensitiveContentOptions.t() | nil,
          sensitiveInfoTypes: [Gleanex.Admin.SensitiveInfoType.t()] | nil,
          version: integer | nil
        }

  defstruct [
    :allowlistOptions,
    :autoHideDocs,
    :broadSharingOptions,
    :createdAt,
    :createdBy,
    :externalSharingOptions,
    :frequency,
    :inputOptions,
    :redactQuote,
    :reportName,
    :sensitiveContentOptions,
    :sensitiveInfoTypes,
    :version
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      allowlistOptions: {Gleanex.Admin.AllowlistOptions, :t},
      autoHideDocs: :boolean,
      broadSharingOptions: {Gleanex.Admin.SharingOptions, :t},
      createdAt: {:string, "iso-date-time"},
      createdBy: {Gleanex.Admin.DlpPerson, :t},
      externalSharingOptions: {Gleanex.Admin.ExternalSharingOptions, :t},
      frequency: :string,
      inputOptions: {Gleanex.Admin.InputOptions, :t},
      redactQuote: :boolean,
      reportName: :string,
      sensitiveContentOptions: {Gleanex.Admin.SensitiveContentOptions, :t},
      sensitiveInfoTypes: [{Gleanex.Admin.SensitiveInfoType, :t}],
      version: {:integer, "int64"}
    ]
  end
end
