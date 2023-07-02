defmodule AuctionWeb.BidController do
  use AuctionWeb, :controller
  import Phoenix.Component
  plug :require_logged_in_user

  def create(conn, %{"bid" => %{"amount" => amount}, "item_id" => item_id}) do
    user_id = conn.assigns.current_user.id
    case Auction.insert_bid(%{amount: amount, item_id: item_id, user_id: user_id}) do
      {:ok, bid} ->
        html = AuctionWeb.CustomComponents.single_bid(
          %{bid: bid, username: conn.assigns.current_user.username})
          |> Phoenix.HTML.Safe.to_iodata()
          |> to_string()
        AuctionWeb.Endpoint.broadcast("item:#{item_id}", "new_bid", %{body: html})
        redirect(conn, to: ~p"/items/#{bid.item_id}")
      {:error, bid} ->
        item = Auction.get_item(item_id)
        conn
        |> put_view(AuctionWeb.ItemView)
        |> render(:show, item: item, bid: bid)
    end
  end

  defp require_logged_in_user(%{assigns: %{current_user: false}} = conn, _opts) do
    conn
    |> put_flash(:error, "Nice try, friend. You must be logged in to bid")
    |> redirect(to: ~p"/items")
    |> halt()
  end

  # If there is a user, pass it on
  defp require_logged_in_user(conn, _opts), do: conn
end
