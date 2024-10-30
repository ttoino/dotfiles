import { App, Astal, Gdk } from "astal/gtk3";
import GtkLayerShell from "gi://GtkLayerShell";

export default function Scrim(monitor: Gdk.Monitor) {
    return (
        <window
            name={`scrim-${monitor.model}`}
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
            setup={(self) => {
                GtkLayerShell.set_namespace(self, "ags-scrim");
            }}
        />
    );
}
