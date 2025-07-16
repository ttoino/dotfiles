import { Astal, Gtk } from "ags/gtk4";
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
import { accessor } from "../lib/vars";

export default function Bar(
    props: Partial<Omit<JSX.IntrinsicElements["window"], "gdkmonitor">> &
        Required<Pick<JSX.IntrinsicElements["window"], "gdkmonitor">>,
) {
    return (
        <window
            name={accessor(props.gdkmonitor).as(
                (monitor) => `bar-${monitor.model}`,
            )}
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={
                Astal.WindowAnchor.BOTTOM |
                Astal.WindowAnchor.LEFT |
                Astal.WindowAnchor.RIGHT
            }
            marginBottom={16}
            marginLeft={16}
            marginRight={16}
            marginTop={0}
            {...props}
        >
            <centerbox class="bar">
                <box halign={Gtk.Align.START} $type="start">
                    <Workspaces />
                </box>
                <box $type="center">
                    <ActiveWindow />
                </box>
                <box halign={Gtk.Align.END} spacing={4} $type="end">
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
