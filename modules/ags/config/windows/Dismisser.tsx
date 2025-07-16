import { Astal, Gdk, Gtk } from "ags/gtk4";
import { dismissPopup } from "../services/windows";
import app from "ags/gtk4/app";
import { Accessor } from "ags";
import { accessor } from "../lib/vars";

export default function Dismisser(
    props: Partial<Omit<JSX.IntrinsicElements["window"], "gdkmonitor">> &
        Required<Pick<JSX.IntrinsicElements["window"], "gdkmonitor">>,
) {
    return (
        <window
            name={accessor(props.gdkmonitor).as(
                (monitor) => `dismisser-${monitor.model}`,
            )}
            namespace="ags-dismisser"
            class="dismisser-window"
            anchor={
                Astal.WindowAnchor.BOTTOM |
                Astal.WindowAnchor.LEFT |
                Astal.WindowAnchor.RIGHT |
                Astal.WindowAnchor.TOP
            }
            layer={Astal.Layer.TOP}
            keymode={Astal.Keymode.EXCLUSIVE}
            exclusivity={Astal.Exclusivity.IGNORE}
            application={app}
            {...props}
        >
            <Gtk.GestureClick onPressed={() => dismissPopup()} />
            <Gtk.EventControllerKey
                onKeyPressed={(self, keyval) => {
                    if (keyval === Gdk.KEY_Escape) dismissPopup();
                }}
            />
        </window>
    );
}
