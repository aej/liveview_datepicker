defmodule LiveviewDatepickerWeb.Components.Datepicker do
  use LiveviewDatepickerWeb, :live_component

  def update(assigns, socket) do
    assigns =
      assigns
      |> Map.put_new(:selected_date, nil)
      |> Map.put(:state, "closed")
      |> set_visible_month_year()

    {:ok, assign(socket, assigns)}
  end

  defp set_visible_month_year(%{selected_date: nil} = assigns) do
    Map.put(assigns, :visible_month_year, %{Date.utc_today() | day: 1})
  end
  defp set_visible_month_year(%{selected_date: d} = assigns), do: Map.put(assigns, :visible_month_year, d)

  def render(assigns) do
    LiveviewDatepickerWeb.DatepickerView.render("index.html", assigns)
  end

  def handle_event("click_datepicker", _, socket) do
    {:noreply, assign(socket, :state, next_state(socket.assigns.state))}
  end

  defp next_state("open"), do: "closed"
  defp next_state("closed"), do: "open"

  def handle_event("click_next", _, socket) do
    {:noreply, socket}
  end

  def handle_event("click_prev", _, socket) do
    previous_month = previous_month(socket.assigns.visible_month_year)
    {:noreply, assign(socket, :visible_month_year, %{previous_month | day: 1})}
  end

  def handle_event("click_next", _, socket) do
    next_month = next_month(socket.assigns.visible_month_year)
    {:noreply, assign(socket, :visible_month_year, %{next_month | day: 1})}
  end

  defp previous_month(%Date{day: day} = date) do
    last_of_last = Date.add(date, -day)
    days_in_last = last_of_last.day
    days = max(day, days_in_last)
    Date.add(date, -days)
  end

  defp next_month(%Date{day: day} = date) do
    days_this_month = Date.days_in_month(date)
    first_of_next   = Date.add(date, days_this_month - day + 1)
    days_next_month = Date.days_in_month(first_of_next)
    Date.add(first_of_next, min(day, days_next_month) - 1)
  end
end
