import { App, Astal, Gtk } from "astal/gtk3";
import CalendarWidget from "../widgets/Calendar";

export default function Calendar() {
    return (
        <window
            name="calendar"
            anchor={Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT}
            margin={16}
            visible={false}
            application={App}
        >
            <scrollable
                className="calendar-window info-window"
                vscroll={Gtk.PolicyType.AUTOMATIC}
                hscroll={Gtk.PolicyType.NEVER}
            >
                <box vertical spacing={16}>
                    <CalendarWidget hexpand vexpand noMonthChange />
                </box>
            </scrollable>
        </window>
    );
}

export const toggleCalendar = () => App.toggle_window("calendar");
