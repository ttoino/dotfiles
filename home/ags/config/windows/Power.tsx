import { App, Astal, Gdk, Gtk } from "astal/gtk3";
import { LOCK, POWER, POWER_SLEEP, RESTART, SNOWFLAKE } from "../lib/chars";
import PowerService from "../providers/power";
import IconButton from "../widgets/IconButton";

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

const ActionButton = ({ name, icon, keybind, action }: Action) => (
    <box className={name}>
        <IconButton
            className="xl"
            onClicked={() => {
                togglePower();
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
            // TODO: This is bugged rn, ON_DEMAND and EXCLUSIVE are swapped
            keymode={Astal.Keymode.ON_DEMAND}
            visible={false}
            application={App}
            onKeyPressEvent={(self, event) => {
                const [result, keyval] = event.get_keyval();
                if (!result) return;

                if (keyval == Gdk.KEY_Escape) return togglePower();

                const action = actions.find((a) => a.keybind == keyval);
                if (action) {
                    togglePower();
                    action?.action();
                }
            }}
        >
            <box valign={Gtk.Align.CENTER} halign={Gtk.Align.CENTER}>
                <box className="power-controls" spacing={16}>
                    {actions.map(ActionButton)}
                </box>
            </box>
        </window>
    );
}

export const togglePower = () => App.toggle_window("power");
