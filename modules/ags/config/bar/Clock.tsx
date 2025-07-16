import { SEPARATOR } from "../lib/chars";
import date from "../providers/date";
import { togglePopup } from "../services/windows";

const label = date.as(
    (date) =>
        `${date.hour}:${date.minute} ${SEPARATOR} ${date.day}/${date.month}/${date.year}`,
);

export default function Clock() {
    return (
        <button
            name="clock"
            onClicked={() => togglePopup("calendar")}
            label={label}
        />
    );
}
