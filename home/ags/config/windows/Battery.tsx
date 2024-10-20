import { bind, Variable } from "astal";
import { App, Astal, Gtk } from "astal/gtk3";
import BatteryService from "gi://AstalBattery";
import PowerProfiles from "gi://AstalPowerProfiles";
import { batteryRange } from "../lib/icons";
import ExpandableWindow from "../widgets/ExpandableWindow";
import IconSlider from "../widgets/IconSlider";

const battery = BatteryService.get_default();
const powerProfiles = PowerProfiles.get_default();

const icon = Variable.derive(
    [bind(battery, "charging"), bind(battery, "percentage")],
    (charging, percent) => batteryRange(charging, percent)
);

const BatterySlider = () => (
    <IconSlider
        hexpand
        drawValue={false}
        icon={icon()}
        value={bind(battery, "percentage")}
    />
);

export default function Battery() {
    return (
        <window
            name="battery"
            anchor={Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT}
            margin={16}
            visible={false}
            application={App}
        >
            <ExpandableWindow
                collapsed={<BatterySlider />}
                expanded={(collapseButton) => (
                    <scrollable
                        vscroll={Gtk.PolicyType.AUTOMATIC}
                        hscroll={Gtk.PolicyType.NEVER}
                    >
                        <box vertical spacing={16}>
                            <box spacing={16}>
                                {collapseButton}
                                <label
                                    hexpand
                                    halign={Gtk.Align.START}
                                    justify={Gtk.Justification.LEFT}
                                    label="Battery"
                                />
                            </box>
                            <BatterySlider />
                        </box>
                    </scrollable>
                )}
            />
        </window>
    );
}

export const toggleBattery = () => App.toggle_window("battery");
