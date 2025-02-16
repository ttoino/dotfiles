import { App, Astal, Gdk } from "astal/gtk3";
import { dismissPopup } from "../services/windows";
import GtkLayerShell from "gi://GtkLayerShell";

export default function Dismisser(monitor: Gdk.Monitor) {
    return (
        <window
            gdkmonitor={monitor}
            name={`dismisser-${monitor.model}`}
            namespace="ags-dismisser"
            className="dismisser-window"
            anchor={
                Astal.WindowAnchor.BOTTOM |
                Astal.WindowAnchor.LEFT |
                Astal.WindowAnchor.RIGHT |
                Astal.WindowAnchor.TOP
            }
            layer={Astal.Layer.TOP}
            keymode={Astal.Keymode.EXCLUSIVE}
            exclusivity={Astal.Exclusivity.IGNORE}
            visible={false}
            onButtonPressEvent={() => dismissPopup()}
            onKeyPressEvent={(self, event) => {
                const [result, keyval] = event.get_keyval();
                if (!result) return;

                if (keyval == Gdk.KEY_Escape) return dismissPopup();
            }}
            application={App}
        />
    );
}
