defmodule AuctionWeb.BidController do
  use AuctionWeb, :controller
  plug :require_logged_in_user

  def create(conn, %{"bid" => %{"amount" => amount}, "item_id" => item_id}) do
    user_id = conn.assigns.current_user.id
    case Auction.insert_bid(%{amount: amount, item_id: item_id, user_id: user_id}) do
      {:ok, bid} -> redirect(conn, to: ~p"/items/#{bid.item_id}")
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
