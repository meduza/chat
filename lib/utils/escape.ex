defmodule Chat.Utils do
  @moduledoc """
  Chat Utils
  """

  @doc """
  Sanitize string
  """
  def sanitize(string) do
    string
    |> Phoenix.HTML.html_escape()
    |> Phoenix.HTML.safe_to_string()
  end
end
