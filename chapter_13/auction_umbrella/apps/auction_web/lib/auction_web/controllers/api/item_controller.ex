defmodule AuctionWeb.Api.ItemController do
  use AuctionWeb, :controller

  def index(conn, _params) do
    items = Auction.list_items()
    render(conn, :index, items: items)
  end

  def show(conn, %{"id" => id}) do
    item = Auction.get_item_with_bids(id)
    render(conn, :show, item: item)
  end
end
