import BatteryService from "gi://AstalBattery";
import PowerProfiles from "gi://AstalPowerProfiles";
import { batteryRange } from "../lib/icons";
import ExpandableWindow from "../widgets/ExpandableWindow";
import IconSlider from "../widgets/IconSlider";
import { Astal, Gtk } from "ags/gtk4";
import app from "ags/gtk4/app";
import { createBinding, createComputed } from "ags";

const battery = BatteryService.get_default();
const powerProfiles = PowerProfiles.get_default();

const icon = createComputed(
    [createBinding(battery, "charging"), createBinding(battery, "percentage")],
    (charging, percent) => batteryRange(charging, percent),
);

const BatterySlider = () => (
    <IconSlider
        hexpand
        drawValue={false}
        sensitive={false}
        icon={icon}
        value={createBinding(battery, "percentage")}
    />
);

export default function Battery(
    props: Partial<JSX.IntrinsicElements["window"]>,
) {
    return (
        <window
            name="battery"
            anchor={Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT}
            margin={16}
            application={app}
            {...props}
        >
            <ExpandableWindow
                collapsed={<BatterySlider />}
                expanded={({collapseButton, ...props}) => (
                    <scrolledwindow
                        vscrollbarPolicy={Gtk.PolicyType.AUTOMATIC}
                        hscrollbarPolicy={Gtk.PolicyType.NEVER}
                        {...props}
                    >
                        <box
                            orientation={Gtk.Orientation.VERTICAL}
                            spacing={16}
                        >
                            <box spacing={16}>
                                {collapseButton}
                                <label
                                    hexpand
                                    halign={Gtk.Align.START}
                                    justify={Gtk.Justification.LEFT}
                                    label="Battery"
                                />
                            </box>
                            <box homogeneous hexpand>
                                {powerProfiles.get_profiles().map((profile) => (
                                    <togglebutton
                                        active={createBinding(
                                            powerProfiles,
                                            "activeProfile",
                                        ).as((p) => p === profile.profile)}
                                    >
                                        {profile.profile}
                                    </togglebutton>
                                ))}
                            </box>
                            <box vexpand />
                            <BatterySlider />
                        </box>
                    </scrolledwindow>
                )}
            />
        </window>
    );
}
