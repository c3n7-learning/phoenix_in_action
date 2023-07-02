defmodule AuctionWeb.ItemControllerTest do
  use AuctionWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Phoenix Framework"
  end
end
