import { App, Astal, Gdk } from "astal/gtk3";
import GtkLayerShell from "gi://GtkLayerShell";

export default function Scrim(monitor: Gdk.Monitor) {
    return (
        <window
            gdkmonitor={monitor}
            name={`scrim-${monitor.model}`}
            namespace="ags-scrim"
            className="scrim-window"
            anchor={
                Astal.WindowAnchor.BOTTOM |
                Astal.WindowAnchor.LEFT |
                Astal.WindowAnchor.RIGHT |
                Astal.WindowAnchor.TOP
            }
            layer={Astal.Layer.OVERLAY}
            exclusivity={Astal.Exclusivity.IGNORE}
            visible={false}
            clickThrough
            application={App}
        />
    );
}
