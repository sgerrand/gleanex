defmodule Gleanex.Admin.DocumentVisibilityUpdateResult do
  @moduledoc """
  Provides struct and type for a DocumentVisibilityUpdateResult
  """

  @type t :: %__MODULE__{
          docId: String.t() | nil,
          override: String.t() | nil,
          success: boolean | nil
        }

  defstruct [:docId, :override, :success]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      docId: :string,
      override:
        {:enum, ["NONE", "HIDE_FROM_ALL", "HIDE_FROM_GROUPS", "HIDE_FROM_ALL_EXCEPT_OWNER"]},
      success: :boolean
    ]
  end
end
