import Notification from "../widgets/Notification";
import Hyprland from "gi://AstalHyprland";
import { Astal, Gdk } from "astal/gtk3";
import Notifications from "../providers/notifications";
import Renderer from "../lib/Renderer";
import { bind } from "astal";

const notifications = Notifications.get_default();
const hyprland = Hyprland.get_default();

export default function Popups(monitor: Gdk.Monitor) {
    const renderer = new Renderer<number>((id) => {
        const notification = notifications.get(id);
        if (notification) return Notification(notification, () => notifications.dismiss(id), true);
    });

    notifications.connect("notified", (_, id) => {
        if (hyprland.focusedMonitor.model === monitor.model)
            renderer.add(id)
        else
            renderer.delete(id);
    });
    notifications.connect("timed-out", (_, id) => renderer.delete(id));
    notifications.connect("dismissed", (_, id) => renderer.delete(id));

    return (
        <window
            gdkmonitor={monitor}
            name={`popups-${monitor.model.replace(/\s/g, "-").toLowerCase()}`}
            className={"popups"}
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
            margin={16}
        >
            <box
                hexpand
                vertical
                spacing={8}
            >
                {bind(renderer)}
            </box>
        </window>
    );
}
