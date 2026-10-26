defmodule Gleanex.Platform.IdpGroup do
  @moduledoc """
  Provides struct and type for a IdpGroup
  """

  @type t :: %__MODULE__{
          display_name: String.t() | nil,
          idp_group_id: String.t() | nil,
          provider: String.t() | nil,
          provider_instance: String.t() | nil
        }

  defstruct [:display_name, :idp_group_id, :provider, :provider_instance]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [display_name: :string, idp_group_id: :string, provider: :string, provider_instance: :string]
  end
end
