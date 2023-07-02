defmodule AuctionWeb.SessionController do
  use AuctionWeb, :controller

  def new(conn, _params) do
    render(conn, :new)
  end

  def create(conn, %{"user" => %{"username" => username, "password" => password}}) do
    case Auction.get_user_by_username_and_password(username, password) do
      %Auction.User{} = user ->
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Successfully logged in")
        |> redirect(to: ~p"/users/#{user.id}")

      _ ->
        conn
        |> put_flash(:error, "That username and password could not be found")
        |> render(:new)
    end
  end

  def delete(conn, _params) do
    # render(conn, :delete)
    conn
    |> clear_session()
    |> configure_session(drop: true)
    |> redirect(to: ~p"/items")
  end
end
