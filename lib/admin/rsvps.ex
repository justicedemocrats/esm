defmodule Rsvps do
  def csv_for(id) do
    all_attendances = Proxy.stream("events/#{id}/rsvps")
    people_ids = Enum.map(all_attendances, & &1.person)

    people_fetch_tasks =
      Enum.map(
        people_ids,
        &Task.async(fn ->
          %{body: body} = Proxy.get("people/#{&1}")
          body
        end)
      )

    people = Enum.map(people_fetch_tasks, fn t -> Task.await(t, :infinity) end)

    csv_content =
      Enum.map(people, fn p ->
        Enum.join(
          [
            Enum.join([p.given_name, p.family_name], " "),
            List.first(p.phone_numbers) |> get_number()
          ],
          ","
        )
      end)

    ["Name,Phone"]
    |> Enum.concat(csv_content)
    |> Enum.join("\n")
  end

  def emails_for(id) do
    all_attendances = Proxy.stream("events/#{id}/rsvps")
    people_ids = Enum.map(all_attendances, & &1.person)

    people_ids
    |> Enum.map(
      &Task.async(fn ->
        %{body: body} = Proxy.get("people/#{&1}")
        body
      end)
    )
    |> Enum.map(fn t -> Task.await(t, :infinity) end)
    |> Enum.map(&(List.first(&1.email_addresses) |> get_email()))
  end

  defp get_email(nil), do: ""
  defp get_email(map), do: Map.get(map, :address, "")
  defp get_number(nil), do: ""
  defp get_number(map), do: Map.get(map, :number, "")
end
