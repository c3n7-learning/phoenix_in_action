defmodule AuctionWeb.UserController do
  use AuctionWeb, :controller

  def show(conn, %{"id" => id}) do
    user = Auction.get_user(id)
    render(conn, :show, user: user)
  end

  def new(conn, _params) do
    user = Auction.new_user()
    render(conn, :new, user: user)
  end

  def create(conn, %{"user" => user_params}) do
    case Auction.insert_user(user_params) do
      {:ok, user} -> redirect(conn, to: ~p"/users/#{user.id}")
      {:error, user} -> render(conn, :new, user: user)
    end
  end
end
