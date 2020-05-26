defmodule LiveviewDatepickerWeb.DatePickerLive do
  use LiveviewDatepickerWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
      <%= live_component @socket, LiveviewDatepickerWeb.Components.Datepicker, id: :my_datepicker %>
    """
  end
end
