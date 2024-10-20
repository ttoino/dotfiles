import { Variable, bind } from "astal";
import BluetoothService from "gi://AstalBluetooth";
import {
    BLUETOOTH,
    BLUETOOTH_CONNECT,
    BLUETOOTH_OFF,
    SEPARATOR,
} from "../lib/chars";
import IconButton from "../widgets/IconButton";
import { toggleBluetooth } from "../windows/Bluetooth";

const bluetooth = BluetoothService.get_default();

const icon = Variable.derive(
    [bind(bluetooth, "isPowered"), bind(bluetooth, "devices")],
    (isPowered, devices) =>
        isPowered
            ? devices.length > 0
                ? BLUETOOTH_CONNECT
                : BLUETOOTH
            : BLUETOOTH_OFF
);
const tooltip = Variable.derive(
    [bind(bluetooth, "isPowered"), bind(bluetooth, "devices")],
    (isPowered, devices) =>
        isPowered
            ? devices.length > 0
                ? devices.map((device) => device.name).join(` ${SEPARATOR} `)
                : "Not connected"
            : "Bluetooth off"
);

export default function Bluetooth() {
    return (
        <IconButton
            className="bluetooth"
            tooltipText={tooltip()}
            onClicked={toggleBluetooth}
        >
            {icon()}
        </IconButton>
    );
}
