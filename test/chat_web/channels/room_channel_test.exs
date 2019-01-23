defmodule ChatWeb.RoomChannelTest do
  use ChatWeb.ChannelCase


  @valid_attrs %{message: "some message", name: "John Do"}
  @invalid_attrs %{message: nil, name: nil}

  setup do
    {:ok, _, socket} =
      socket(ChatWeb.UserSocket, "user_id", %{some: :assign})
      |> subscribe_and_join(ChatWeb.RoomChannel, "room:main")

    {:ok, socket: socket}
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push socket, "ping", %{"hello" => "there"}
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "shout broadcasts to room:main", %{socket: socket} do
    push socket, "shout", @valid_attrs
    assert_broadcast "shout", %{"message" => "some message", "name" => "John Do"}
  end

  test "shout broadcasts invalid params to room:main replies with error", %{socket: socket} do
    push socket, "shout", @invalid_attrs
    assert_push "error", %{"reason" => "Name or message can't be blank"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
  end
end
