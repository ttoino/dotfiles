import Clock from "../bar/clock.js";
import Gtk from "gi://Gtk?version=3.0";
import ActiveWindow from "../bar/active.js";
import Workspaces from "../bar/workspaces.js";
import Battery from "../bar/battery.js";
import Network from "../bar/network.js";
import Bluetooth from "../bar/bluetooth.js";
import Brightness from "../bar/brightness.js";
import Audio from "../bar/audio.js";
import Media from "../bar/media.js";
import Notifications from "../bar/notifications.js";

/**
 * @param {number} monitor
 */
const Bar = (monitor) =>
    Widget.Window({
        monitor,
        name: `bar-${monitor}`,
        anchor: ["bottom", "left", "right"],
        margins: [0, 16, 16, 16],
        exclusivity: "exclusive",
        child: Widget.CenterBox({
            className: "bar",
            spacing: 8,
            homogeneous: true,
            start_widget: Widget.Box({
                halign: Gtk.Align.START,
                children: [Workspaces()],
            }),
            center_widget: Widget.Box({
                children: [ActiveWindow()],
            }),
            end_widget: Widget.Box({
                halign: Gtk.Align.END,
                spacing: 4,
                children: [
                    Media(),
                    Audio(),
                    Brightness(),
                    Bluetooth(),
                    Network(),
                    Battery(),
                    Notifications(),
                    Clock(),
                ],
            }),
        }),
    });

export default Bar;
