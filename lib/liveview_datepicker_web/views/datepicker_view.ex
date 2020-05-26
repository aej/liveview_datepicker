defmodule LiveviewDatepickerWeb.DatepickerView do
  use LiveviewDatepickerWeb, :view

  @month_names ~w(January February March April May June July August September October November December)
  def full_month_name(date), do: Enum.at(@month_names, date.month - 1)

  def full_year(date), do: to_string(date.year)

  def blank_cells(%Date{day: 1} = date) do
    dow = Date.day_of_week(date)
    case dow do
      7 -> 0
      _ -> dow
    end
  end

  def selectable_cells(%Date{day: 1} = date) do
    today = Date.utc_today()
    if same_month?(today, date), do: today.day, else: Date.days_in_month(date)
  end

  def unselectable_cells(%Date{day: 1} = date) do
    today = Date.utc_today()
    if same_month?(today, date), do: Date.days_in_month(date) - date.day, else: 0
  end

  defp same_month?(%{month: m, year: y}, %{month: m, year: y}), do: true
  defp same_month?(_d1, _d2), do: false
end
