defmodule AuctionWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "item:*", AuctionWeb.ItemChannel

  def connect(params, socket, _connect_info) do
    {:ok, assign(socket, :user_id, params["user_id"])}
  end

  def id(socket), do: "users_socket:#{socket.assigns.user_id}"
end

# AuctionWeb.Endpoint.broadcast("user_socket:" <> user.id, "disconnect", %{})
