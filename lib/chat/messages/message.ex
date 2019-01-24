defmodule Chat.Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chat.Utils


  schema "messages" do
    field :message, :string
    field :name, :string

    timestamps()
  end


  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:name, :message])
    |> validate_required([:name, :message])
    |> sanitize_message()
  end


  defp sanitize_message(changeset) do
    changeset
    |> put_change(:name, Utils.sanitize(get_field(changeset, :name)))
    |> put_change(:message, Utils.sanitize(get_field(changeset, :message)))
  end

end
