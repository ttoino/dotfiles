import { bind } from "astal";
import { App, Astal, Gtk } from "astal/gtk3";
import NetworkService from "gi://AstalNetwork";
import AccessPoint from "../widgets/AccessPoint";

const network = NetworkService.get_default();

const Ethernet = () => (
    <box spacing={16}>
        <label
            hexpand
            halign={Gtk.Align.START}
            justify={Gtk.Justification.LEFT}
            label="Ethernet"
        />
        <switch
            hexpand={false}
            active={bind(network.wired, "state").as(
                (state) => state === NetworkService.DeviceState.ACTIVATED
            )}
            sensitive={false}
        />
    </box>
);

const Wifi = () => (
    <box vertical spacing={8}>
        <box spacing={16}>
            <label
                hexpand
                halign={Gtk.Align.START}
                justify={Gtk.Justification.LEFT}
                label="Wifi"
            />
            <switch hexpand={false} active={bind(network.wifi, "enabled")} />
        </box>
        <box vertical spacing={8}>
            {bind(network.wifi, "access_points").as((aps) =>
                aps
                    .sort(
                        (a, b) =>
                            Number(b == network.wifi.activeAccessPoint) -
                                Number(a == network.wifi.activeAccessPoint) ||
                            b.strength - a.strength
                    )
                    .map((ap) => (
                        <AccessPoint
                            ap={ap}
                            active={ap == network.wifi.activeAccessPoint}
                        />
                    ))
            )}
        </box>
    </box>
);

export default function Network() {
    return (
        <window
            name="network"
            anchor={Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT}
            margin={16}
            visible={false}
            application={App}
        >
            <scrollable
                className="network-window info-window"
                vscroll={Gtk.PolicyType.AUTOMATIC}
                hscroll={Gtk.PolicyType.NEVER}
            >
                <box vertical spacing={16}>
                    <Ethernet />
                    <Wifi />
                </box>
            </scrollable>
        </window>
    );
}

export const toggleNetwork = () => App.toggle_window("network");
