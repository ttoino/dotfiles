import { App, Astal, Gdk, Gtk } from "astal/gtk3";
import GtkLayerShell from "gi://GtkLayerShell";
import { LOCK, POWER, POWER_SLEEP, RESTART, SNOWFLAKE } from "../lib/chars";
import PowerService from "../providers/power";
import IconButton from "../widgets/IconButton";
import { dismissPopup } from "../services/windows";

const power = PowerService.get_default();

interface Action {
    name: string;
    icon: string;
    keybind: number;
    action: () => void;
}

const actions = [
    {
        name: "shutdown",
        icon: POWER,
        keybind: Gdk.KEY_s,
        action: power.shutdown,
    },
    {
        name: "restart",
        icon: RESTART,
        keybind: Gdk.KEY_r,
        action: power.restart,
    },
    {
        name: "sleep",
        icon: POWER_SLEEP,
        keybind: Gdk.KEY_z,
        action: power.sleep,
    },
    {
        name: "hibernate",
        icon: SNOWFLAKE,
        keybind: Gdk.KEY_h,
        action: power.hibernate,
    },
    {
        name: "lock",
        icon: LOCK,
        keybind: Gdk.KEY_l,
        action: power.lock,
    },
] as const satisfies Action[];

const ActionButton = ({ name, icon, action }: Action) => (
    <box className={name}>
        <IconButton
            className="xl"
            onClicked={() => {
                dismissPopup();
                action();
            }}
        >
            {icon}
        </IconButton>
    </box>
);

export default function Power() {
    return (
        <window
            name="power"
            className="power-window"
            anchor={
                Astal.WindowAnchor.BOTTOM |
                Astal.WindowAnchor.LEFT |
                Astal.WindowAnchor.RIGHT |
                Astal.WindowAnchor.TOP
            }
            layer={Astal.Layer.OVERLAY}
            keymode={Astal.Keymode.EXCLUSIVE}
            exclusivity={Astal.Exclusivity.IGNORE}
            visible={false}
            clickThrough
            application={App}
            onKeyPressEvent={(self, event) => {
                const [result, keyval] = event.get_keyval();
                if (!result) return;

                // if (keyval == Gdk.KEY_Escape) return dismissPopup();

                const action = actions.find((a) => a.keybind == keyval);
                if (action) {
                    dismissPopup();
                    action?.action();
                }
            }}
        >
            <box
                valign={Gtk.Align.CENTER}
                halign={Gtk.Align.CENTER}
                clickThrough
            >
                <box
                    className="power-controls"
                    spacing={16}
                    clickThrough={false}
                >
                    {actions.map(ActionButton)}
                </box>
            </box>
        </window>
    );
}
