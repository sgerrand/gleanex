defmodule Gleanex.Admin.DocumentVisibilityOverride do
  @moduledoc """
  Provides struct and type for a DocumentVisibilityOverride
  """

  @type t :: %__MODULE__{docId: String.t() | nil, override: String.t() | nil}

  defstruct [:docId, :override]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      docId: :string,
      override:
        {:enum, ["NONE", "HIDE_FROM_ALL", "HIDE_FROM_GROUPS", "HIDE_FROM_ALL_EXCEPT_OWNER"]}
    ]
  end
end
