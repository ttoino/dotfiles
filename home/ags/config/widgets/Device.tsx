import { bind } from "astal";
import { Gtk } from "astal/gtk3/index";
import Bluetooth from "gi://AstalBluetooth";
import {
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

export default function Device(device: Bluetooth.Device) {
    return (
        <eventbox
            cursor="pointer"
            setup={(self) => {
                bind(device, "paired").subscribe((paired) => {
                    self.toggleClassName("paired", paired);
                });
                bind(device, "connecting").subscribe((connecting) => {
                    self.toggleClassName("connecting", connecting);
                });
                bind(device, "connected").subscribe((connected) => {
                    self.toggleClassName("connected", connected);
                });
            }}
        >
            <box className="device" spacing={16}>
                <label
                    className="icon pictogram"
                    label={bind(device, "icon").as((icon_name) =>
                        icon_name in ICONS
                            ? ICONS[icon_name as keyof typeof ICONS]
                            : icon_name
                    )}
                    // tooltipText={bind(device, "type")}
                />
                <box vertical>
                    <label
                        label={bind(device, "name")}
                        halign={Gtk.Align.START}
                        hexpand
                        lines={1}
                        wrap={false}
                    />
                    <label
                        className="secondary"
                        label={bind(device, "address")}
                        halign={Gtk.Align.START}
                        hexpand
                        lines={1}
                        wrap={false}
                    />
                </box>
            </box>
        </eventbox>
    );
}
