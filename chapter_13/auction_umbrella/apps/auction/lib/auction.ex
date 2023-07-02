defmodule Auction do
  alias Auction.{Bid, Repo, Item, User, Password}
  import Ecto.Query

  @repo Repo

  def list_items do
    @repo.all(Item)
  end

  def get_item(id) do
    @repo.get!(Item, id)
  end

  def get_item_with_bids(id) do
    id
    |> get_item()
    |> @repo.preload(bids: from(b in Bid, order_by: [desc: b.inserted_at]))
    |> @repo.preload(bids: [:user])
  end

  def get_item_by(attrs) do
    @repo.get_by(Item, attrs)
  end

  def insert_item(attrs) do
    %Item{}
    |> Item.changeset(attrs)
    |> @repo.insert()
  end

  def update_item(%Item{} = item, updates) do
    item
    |> Item.changeset(updates)
    |> @repo.update()
  end

  def delete_item(%Item{} = item), do: @repo.delete(item)

  def new_item, do: Item.changeset(%Item{})

  def edit_item(id) do
    get_item(id)
    |> Item.changeset()
  end

  def get_user(id), do: @repo.get!(User, id)

  def new_user, do: User.changeset_with_password(%User{})

  def insert_user(params) do
    %User{}
    |> User.changeset_with_password(params)
    |> @repo.insert()
  end

  @doc """
  Retrieves a User from the database matching the provided username and password

  ## Return values
  Depending on what is found in the database, two different values cold be returned:
  * An `Auction.User` struct: An `Auction.User` record was found that matched
  the `username` and `password` that was provided.
  * `false`: No `Auction.User` could be found with the provided `username`
  and `pasword`

  You can then use the returned value to determine whether or not the User is
  authorized in your application. In an `Auction.User` is _not_ found based on
  `username`, the computational work of hashing a password is still done
  """
  def get_user_by_username_and_password(username, password) do
    with user when not is_nil(user) <- @repo.get_by(User, %{username: username}),
         true <- Password.verify_with_hash(password, user.hashed_password) do
      user
    else
      _ -> Password.dummy_verify()
    end
  end

  def insert_bid(params) do
    %Bid{}
    |> Bid.changeset(params)
    |> @repo.insert()
  end

  def new_bid, do: Bid.changeset(%Bid{})

  def get_bids_for_user(user) do
    query =
      from(b in Bid,
        where: b.user_id == ^user.id,
        order_by: [desc: :inserted_at],
        preload: :item,
        limit: 10
      )

    @repo.all(query)
  end
end
