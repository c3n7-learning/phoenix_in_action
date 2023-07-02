defmodule AuctionWeb.Api.ItemJSON do
  def index(%{items: items}) do
    %{
      data:
        for(
          item <- items,
          do: %{
            type: "item",
            id: item.id,
            title: item.title,
            description: item.description,
            ends_at: item.ends_at
          }
        )
    }
  end

  def show(%{item: item}) do
    %{
      data: %{
        type: "item",
        id: item.id,
        title: item.title,
        description: item.description,
        ends_at: item.ends_at,
        bids:
          for(
            bid <- item.bids,
            do: %{
              type: "bid",
              id: bid.id,
              amount: bid.amount,
              user: %{
                username: bid.user.username
              }
            }
          )
      }
    }
  end
end
