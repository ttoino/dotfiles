import { toggleBluetooth } from "../windows/bluetooth.js";
import {
    BLUETOOTH,
    BLUETOOTH_CONNECT,
    BLUETOOTH_OFF,
    SEPARATOR,
} from "../chars.js";

const bluetooth = await Service.import("bluetooth");

const Bluetooth = () =>
    Widget.Button({
        classNames: ["icon", "bluetooth"],
        onClicked: () => {
            toggleBluetooth();
        },
    }).hook(bluetooth, (self) => {
        self.label = bluetooth.enabled
            ? bluetooth.connected_devices.length > 0
                ? BLUETOOTH_CONNECT
                : BLUETOOTH
            : BLUETOOTH_OFF;

        self.tooltip_text = bluetooth.enabled
            ? bluetooth.connected_devices.length > 0
                ? bluetooth.connected_devices
                      .map((device) => device.name)
                      .join(` ${SEPARATOR} `)
                : "Not connected"
            : "Bluetooth off";
    });

export default Bluetooth;
