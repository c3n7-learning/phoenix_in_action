defmodule Auction.Item do
  defstruct [:id, :title, :description, :ends_at]
end

defmodule Auction do
  alias Auction.{FakeRepo, Item}

  @repo FakeRepo

  def list_items do
    @repo.all(Item)
  end

  def get_item(id) do
    @repo.get!(Item, id)
  end

  def get_item_by(attrs) do
    @repo.get_by(Item, attrs)
  end
end

defmodule Auction.FakeRepo do
  alias Auction.Item

  @items [
    %Item{
      id: 1,
      title: "My first item:",
      description: "A tasty item sure to please",
      ends_at: ~N[2020-02-03 00:00:00]
    },
    %Item{
      id: 2,
      title: "WarGames Bluray",
      description: "A tasty item sure to please",
      ends_at: ~N[2023-02-03 00:00:00]
    },
    %Item{
      id: 3,
      title: "The River Between",
      description: "A tasty item sure to please",
      ends_at: ~N[2000-02-03 00:00:00]
    }
  ]

  def all(Item), do: @items

  def get!(Item, id) do
    Enum.find(@items, fn item -> item.id === id end)
  end

  def get_by(Item, attrs) do
    Enum.find(@items, fn item ->
      Enum.all?(Map.keys(attrs), fn key ->
        Map.get(item, key) === attrs[key]
      end)
    end)
  end
end
