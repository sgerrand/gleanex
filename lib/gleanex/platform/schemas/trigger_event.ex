defmodule Gleanex.Platform.TriggerEvent do
  @moduledoc """
  Provides struct and type for a TriggerEvent
  """

  @type t :: %__MODULE__{
          datasource: String.t(),
          doc_id: String.t(),
          doc_type: String.t(),
          event_time: DateTime.t(),
          event_type: String.t(),
          reason: String.t(),
          title: String.t(),
          view_url: String.t()
        }

  defstruct [
    :datasource,
    :doc_id,
    :doc_type,
    :event_time,
    :event_type,
    :reason,
    :title,
    :view_url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      datasource: :string,
      doc_id: :string,
      doc_type: :string,
      event_time: {:string, "date-time"},
      event_type: {:const, "DOCUMENT_CHANGE"},
      reason:
        {:enum,
         [
           "CREATED",
           "UPDATED",
           "DELETED",
           "MEETS_CONDITION",
           "ASSIGNED",
           "UNASSIGNED",
           "LABELED",
           "UNLABELED",
           "REVIEW_REQUESTED",
           "REVIEW_REQUEST_REMOVED",
           "READY_FOR_REVIEW",
           "CONVERTED_TO_DRAFT",
           "WEBHOOK_UPDATED"
         ]},
      title: :string,
      view_url: :string
    ]
  end
end
