defmodule AuctionWeb.CustomComponents do
  use Phoenix.Component
  import AuctionWeb.CoreComponents
  import AuctionWeb.GlobalHelpers

  def item_form(assigns) do
    ~H"""
    <.form for={@item} action={@action} :let={f}>
    <%= if @item.action do %>
    <div class="bg-red-50 text-red-500 rounded p-5 my-5 flex flex-col space-y-2">
    <span class="font-bold text-sm">Error</span>
    <span>
      Unfortunately, there are errors in your submission
    </span>
    </div>
    <% end %>
    <.input field={f[:title]} label="Title" />
    <.input type="textarea" field={f[:description]} label="Description" />
    <.input field={f[:ends_at]} label="Auction ends at" type="datetime-local" />

    <.button type="submit" class="mt-2">Submit</.button>
    </.form>
    """
  end

  def single_bid(assigns) do
    ~H"""
      <p>
        <%= integer_to_currency(@bid.amount) %>
        <em> <span class="text-xs">from</span> <%= @bid.user.username %></em>
      </p>
    """
  end
end
