import BluetoothService from "gi://AstalBluetooth";
import {
    BLUETOOTH,
    CAMERA,
    CELLPHONE,
    CONTROLLER,
    HEADPHONES,
    HEADSET,
    KEYBOARD,
    LAPTOP,
    MOUSE,
    PRINTER,
    SCANNER,
    SPEAKER,
    VIDEO,
} from "../lib/chars";
import BaseDevice from "../widgets/Device";
import { ascending, descending } from "../lib/sorting";
import { createBinding, For } from "ags";
import { Astal, Gtk } from "ags/gtk4";
import app from "ags/gtk4/app";

const bluetooth = BluetoothService.get_default();

const ICONS = {
    "audio-speakers": SPEAKER,
    "audio-headset": HEADSET,
    "audio-headphones": HEADPHONES,
    "camera-photo": CAMERA,
    "camera-video": VIDEO,
    computer: LAPTOP,
    "input-gaming": CONTROLLER,
    "input-keyboard": KEYBOARD,
    "input-mouse": MOUSE,
    phone: CELLPHONE,
    printer: PRINTER,
    scanner: SCANNER,
    "video-display": VIDEO,
};

const Device = (device: BluetoothService.Device) => (
    <BaseDevice
        title={createBinding(device, "name")}
        subtitle={createBinding(device, "address")}
        icon={createBinding(device, "icon").as((icon_name) =>
            icon_name in ICONS
                ? ICONS[icon_name as keyof typeof ICONS]
                : BLUETOOTH,
        )}
        iconTooltip={createBinding(device, "icon")}
        active={createBinding(device, "connected")}
        activating={createBinding(device, "connecting")}
        onPrimaryClick={() =>
            device.connected
                ? device.disconnect_device(null)
                : device.connect_device(null)
        }
    />
);

export default function Bluetooth(
    props: Partial<JSX.IntrinsicElements["window"]>,
) {
    const devices = createBinding(bluetooth, "devices").as((devices) =>
        devices.toSorted(
            (a, b) =>
                descending(a.connected, b.connected) ||
                descending(a.paired, b.paired) ||
                ascending(a.name ?? a.address ?? "", b.name ?? b.address ?? ""),
        ),
    );

    return (
        <window
            name="bluetooth"
            anchor={Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT}
            margin={16}
            application={app}
            {...props}
        >
            <scrolledwindow
                class="bluetooth-window info-window"
                hscrollbarPolicy={Gtk.PolicyType.NEVER}
                vscrollbarPolicy={Gtk.PolicyType.AUTOMATIC}
            >
                <box orientation={Gtk.Orientation.VERTICAL} spacing={8}>
                    <box spacing={16}>
                        <label
                            hexpand
                            halign={Gtk.Align.START}
                            justify={Gtk.Justification.LEFT}
                            label="Bluetooth"
                        />
                        <switch
                            hexpand={false}
                            active={createBinding(bluetooth, "isPowered")}
                            onStateSet={(self) =>
                                self.state === bluetooth.isPowered &&
                                bluetooth.toggle()
                            }
                        />
                    </box>
                    <box orientation={Gtk.Orientation.VERTICAL} spacing={8}>
                        <For each={devices}>{Device}</For>
                    </box>
                </box>
            </scrolledwindow>
        </window>
    );
}
