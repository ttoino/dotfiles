import { Astal, Gtk } from "ags/gtk4";
import app from "ags/gtk4/app";

export default function Calendar(
    props: Partial<JSX.IntrinsicElements["window"]>,
) {
    return (
        <window
            name="calendar"
            anchor={Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT}
            margin={16}
            visible={false}
            application={app}
            {...props}
        >
            <scrolledwindow
                class="calendar-window info-window"
                vscrollbarPolicy={Gtk.PolicyType.AUTOMATIC}
                hscrollbarPolicy={Gtk.PolicyType.NEVER}
            >
                <box orientation={Gtk.Orientation.VERTICAL} spacing={16}>
                    <Gtk.Calendar hexpand vexpand />
                </box>
            </scrolledwindow>
        </window>
    );
}
