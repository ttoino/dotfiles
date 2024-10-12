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
} from "../chars.js";

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

/**
 * @param {import("types/service/bluetooth").BluetoothDevice} device
 */
const Device = (device) =>
    Widget.EventBox({
        cursor: "pointer",
        onPrimaryClick: () => device.setConnection(!device.connected),
        child: Widget.Box({
            className: "device",
            spacing: 16,
            children: [
                Widget.Label({
                    classNames: ["icon", "pictogram"],
                    label: device
                        .bind("icon_name")
                        .transform(
                            (icon_name) => ICONS[icon_name] || icon_name
                        ),
                    tooltip_text: device.bind("type"),
                }),
                Widget.Box({
                    vertical: true,
                    children: [
                        Widget.Label({
                            label: device.name,
                            hpack: "start",
                            hexpand: true,
                            lines: 1,
                            wrap: false,
                        }),
                        Widget.Label({
                            label: device.address,
                            classNames: ["secondary"],
                            hpack: "start",
                            hexpand: true,
                            lines: 1,
                            wrap: false,
                        }),
                    ],
                }),
            ],
        }).hook(device, (self) => {
            self.toggleClassName("paired", device.paired);
            self.toggleClassName("connecting", device.connecting);
            self.toggleClassName("connected", device.connected);
        }),
    });

export default Device;
