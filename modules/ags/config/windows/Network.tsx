import NetworkService from "gi://AstalNetwork";
import Device from "../widgets/Device";
import { wifiRange } from "../lib/icons";
import { ascending, descending } from "../lib/sorting";
import { Astal, Gtk } from "ags/gtk4";
import { createBinding, createComputed, For } from "ags";
import app from "ags/gtk4/app";

const network = NetworkService.get_default();

const Ethernet = () =>
    network.wired && (
        <box spacing={16}>
            <label
                hexpand
                halign={Gtk.Align.START}
                justify={Gtk.Justification.LEFT}
                label="Ethernet"
            />
            <switch
                hexpand={false}
                active={createBinding(network.wired, "state").as(
                    (state) => state === NetworkService.DeviceState.ACTIVATED,
                )}
                sensitive={false}
            />
        </box>
    );

const AccessPoint = (ap: NetworkService.AccessPoint) => {
    const isActive = createBinding(network.wifi, "activeAccessPoint").as(
        (active) => active === ap,
    );

    return (
        <Device
            title={createBinding(ap, "ssid")}
            icon={createBinding(ap, "strength").as(wifiRange)}
            active={createComputed(
                [isActive, createBinding(network.wifi, "state")],
                (active, state) =>
                    active && state === NetworkService.DeviceState.ACTIVATED,
            )}
            activating={createComputed(
                [isActive, createBinding(network.wifi, "state")],
                (active, state) =>
                    active && state !== NetworkService.DeviceState.ACTIVATED,
            )}
        />
    );
};

const Wifi = () => {
    const aps = createBinding(network.wifi, "accessPoints").as((aps) =>
        aps.toSorted(
            (a, b) =>
                descending(
                    a === network.wifi.activeAccessPoint,
                    b === network.wifi.activeAccessPoint,
                ) ||
                descending(a.strength, b.strength) ||
                ascending(a.ssid ?? "", b.ssid ?? ""),
        ),
    );

    return (
        <box orientation={Gtk.Orientation.VERTICAL} spacing={8}>
            <box spacing={16}>
                <label
                    hexpand
                    halign={Gtk.Align.START}
                    justify={Gtk.Justification.LEFT}
                    label="Wifi"
                />
                <switch
                    hexpand={false}
                    active={createBinding(network.wifi, "enabled")}
                />
            </box>
            <box orientation={Gtk.Orientation.VERTICAL} spacing={8}>
                <For each={aps}>{AccessPoint}</For>
            </box>
        </box>
    );
};

export default function Network(
    props: Partial<JSX.IntrinsicElements["window"]>,
) {
    return (
        <window
            name="network"
            anchor={Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT}
            margin={16}
            application={app}
            {...props}
        >
            <scrolledwindow
                class="network-window info-window"
                vscrollbarPolicy={Gtk.PolicyType.AUTOMATIC}
                hscrollbarPolicy={Gtk.PolicyType.NEVER}
            >
                <box orientation={Gtk.Orientation.VERTICAL} spacing={16}>
                    <Ethernet />
                    <Wifi />
                </box>
            </scrolledwindow>
        </window>
    );
}
