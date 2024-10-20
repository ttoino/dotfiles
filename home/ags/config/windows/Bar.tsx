import { Astal, Gdk, Gtk } from "astal/gtk3";
import ActiveWindow from "../bar/ActiveWindow";
import Audio from "../bar/Audio";
import Battery from "../bar/Battery";
import Bluetooth from "../bar/Bluetooth";
import Brightness from "../bar/Brightness";
import Clock from "../bar/Clock";
import Media from "../bar/Media";
import Network from "../bar/Network";
import Notifications from "../bar/Notifications";
import Workspaces from "../bar/Workspaces";

export default function Bar(monitor: Gdk.Monitor) {
    return (
        <window
            gdkmonitor={monitor}
            name={`bar-${monitor.model}`}
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={
                Astal.WindowAnchor.BOTTOM |
                Astal.WindowAnchor.LEFT |
                Astal.WindowAnchor.RIGHT
            }
            marginBottom={16}
            marginStart={16}
            marginEnd={16}
            marginTop={0}
        >
            <centerbox className="bar" spacing={8} homogeneous>
                <box halign={Gtk.Align.START}>
                    <Workspaces />
                </box>
                <box>
                    <ActiveWindow />
                </box>
                <box halign={Gtk.Align.END} spacing={4}>
                    <Media />
                    <Audio />
                    <Brightness />
                    <Bluetooth />
                    <Network />
                    <Battery />
                    <Notifications />
                    <Clock />
                </box>
            </centerbox>
        </window>
    );
}
