import { LOCK, POWER, POWER_SLEEP, RESTART, SNOWFLAKE } from "../lib/chars";
import PowerService from "../providers/power";
import IconButton from "../widgets/IconButton";
import { dismissPopup } from "../services/windows";
import { Astal, Gdk, Gtk } from "ags/gtk4";
import app from "ags/gtk4/app";

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
    <box class={name}>
        <IconButton
            class="xl"
            onClicked={() => {
                dismissPopup();
                action();
            }}
        >
            {icon}
        </IconButton>
    </box>
);

export default function Power(props: Partial<JSX.IntrinsicElements["window"]>) {
    return (
        <window
            name="power"
            class="power-window"
            anchor={
                Astal.WindowAnchor.BOTTOM |
                Astal.WindowAnchor.LEFT |
                Astal.WindowAnchor.RIGHT |
                Astal.WindowAnchor.TOP
            }
            layer={Astal.Layer.OVERLAY}
            keymode={Astal.Keymode.EXCLUSIVE}
            exclusivity={Astal.Exclusivity.IGNORE}
            application={app}
            {...props}
        >
            <Gtk.EventControllerKey
                onKeyPressed={(self, key) => {
                    const action = actions.find((a) => a.keybind == key);
                    if (action) {
                        dismissPopup();
                        action?.action();
                    }
                }}
            />

            <box valign={Gtk.Align.CENTER} halign={Gtk.Align.CENTER}>
                <box class="power-controls" spacing={16}>
                    {actions.map(ActionButton)}
                </box>
            </box>
        </window>
    );
}
