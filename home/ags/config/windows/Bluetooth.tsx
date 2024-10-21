import { bind } from "astal";
import { App, Astal, Gtk } from "astal/gtk3";
import BluetoothService from "gi://AstalBluetooth";
import Device from "../widgets/Device";

const bluetooth = BluetoothService.get_default();

export default function Bluetooth() {
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
                            // onStateSet={() => bluetooth.toggle()}
                        />
                    </box>
                    <box vertical spacing={8}>
                        {bind(bluetooth, "devices").as((devices) =>
                            devices
                                .sort(
                                    (a, b) =>
                                        Number(b.connected) -
                                            Number(a.connected) ||
                                        Number(b.paired) - Number(a.paired) ||
                                        a.name.localeCompare(b.name)
                                )
                                .map(Device)
                        )}
                    </box>
                </box>
            </scrollable>
        </window>
    );
}

export const toggleBluetooth = () => App.toggle_window("bluetooth");
