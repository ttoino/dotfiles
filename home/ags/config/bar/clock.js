import { toggleCalendar } from "../windows/calendar.js";
import { SEPARATOR } from "../chars.js";
import date from "../vars/date.js";

const label = date
    .bind()
    .transform(
        (date) =>
            `${date.hour}:${date.minute} ${SEPARATOR} ${date.day}/${date.month}/${date.year}`
    );

const Clock = () =>
    Widget.Button({
        name: "clock",
        label,
        onClicked: () => {
            toggleCalendar();
        }
    });

export default Clock;
