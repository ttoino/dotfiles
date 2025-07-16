import app from "ags/gtk4/app";
import Bluetooth from "gi://AstalBluetooth";
import { notify } from "../../lib/notifications";

const bluetooth = Bluetooth.get_default();

bluetooth.connect("device-added", (bluetooth, device) => {
    if (app.get_window("bluetooth")?.visible) return;

    if (!device?.connected) return;

    notify({
        title: `${device?.name} connected`,
        className: "bluetooth",
        transient: true,
    });
});

bluetooth.connect("device-removed", (bluetooth, device) => {
    if (app.get_window("bluetooth")?.visible) return;

    notify({
        title: `${device?.name} disconnected`,
        className: "bluetooth",
        transient: true,
    });
});

export {};
