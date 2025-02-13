import { bind } from "astal";
import { App, Astal, Gtk } from "astal/gtk3";
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
import Renderer from "../lib/Renderer";

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
        title={bind(device, "name")}
        subtitle={bind(device, "address")}
        icon={bind(device, "icon").as((icon_name) =>
            icon_name in ICONS
                ? ICONS[icon_name as keyof typeof ICONS]
                : BLUETOOTH
        )}
        iconTooltip={bind(device, "icon")}
        active={bind(device, "connected")}
        activating={bind(device, "connecting")}
        onPrimaryClick={() =>
            device.connected
                ? device.disconnect_device(null)
                : device.connect_device(null)
        }
    />
);

export default function Bluetooth() {
    const renderer = new Renderer<BluetoothService.Device>((device) => Device(device), {
        initial: bluetooth.devices,
        sort: (a, b) =>
            Number(b.connected) - Number(a.connected) ||
            Number(b.paired) - Number(a.paired) ||
            a.name?.localeCompare(b.name) ||
            a.address?.localeCompare(b.address),
    });

    bluetooth.connect("device-added", (_, device) => renderer.add(device));
    bluetooth.connect("device-removed", (_, device) => renderer.delete(device));

    return (
        <window
            name="bluetooth"
            anchor={Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT}
            margin={16}
            visible={false}
            application={App}
        >
            <scrollable
                className="bluetooth-window info-window"
                hscroll={Gtk.PolicyType.NEVER}
                vscroll={Gtk.PolicyType.AUTOMATIC}
            >
                <box vertical spacing={8}>
                    <box spacing={16}>
                        <label
                            hexpand
                            halign={Gtk.Align.START}
                            justify={Gtk.Justification.LEFT}
                            label="Bluetooth"
                        />
                        <switch
                            hexpand={false}
                            active={bind(bluetooth, "isPowered")}
                            onStateSet={(self) =>
                                self.state === bluetooth.isPowered &&
                                bluetooth.toggle()
                            }
                        />
                    </box>
                    <box vertical spacing={8}>
                        {bind(renderer)}
                    </box>
                </box>
            </scrollable>
        </window>
    );
}
