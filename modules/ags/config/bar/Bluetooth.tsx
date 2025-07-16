import BluetoothService from "gi://AstalBluetooth";
import {
    BLUETOOTH,
    BLUETOOTH_CONNECT,
    BLUETOOTH_OFF,
    SEPARATOR,
} from "../lib/chars";
import IconButton from "../widgets/IconButton";
import { togglePopup } from "../services/windows";
import { createBinding, createComputed } from "ags";

const bluetooth = BluetoothService.get_default();

const connected = createBinding(bluetooth, "devices").as((devices) =>
    devices.filter((d) => d.connected),
);
const icon = createComputed(
    [createBinding(bluetooth, "isPowered"), connected],
    (isPowered, devices) =>
        isPowered
            ? devices.length > 0
                ? BLUETOOTH_CONNECT
                : BLUETOOTH
            : BLUETOOTH_OFF,
);
const tooltip = createComputed(
    [createBinding(bluetooth, "isPowered"), connected],
    (isPowered, devices) =>
        isPowered
            ? devices.length > 0
                ? devices.map((device) => device.name).join(` ${SEPARATOR} `)
                : "Not connected"
            : "Bluetooth off",
);

export default function Bluetooth() {
    return (
        <IconButton
            class="bluetooth"
            tooltipText={tooltip}
            onClicked={() => togglePopup("bluetooth")}
            label={icon}
        />
    );
}
