defmodule AuctionWeb.ItemHTML do
  use AuctionWeb, :html

  embed_templates("item_html/*")

  def integer_to_currency(cents) do
    dollars_and_cents =
      cents
      |> Decimal.div(100)
      |> Decimal.round(2)
    "KES #{dollars_and_cents}"
  end
end
