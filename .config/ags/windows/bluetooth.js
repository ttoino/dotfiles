import Device from "../widgets/device.js";

const bluetooth = await Service.import("bluetooth");

const Bluetooth = () =>
    Widget.Window({
        name: `bluetooth`,
        anchor: ["bottom", "right"],
        margins: [16],
        visible: false,
        child: Widget.Scrollable({
            classNames: ["bluetooth-window", "info-window"],
            hscroll: "never",
            vscroll: "automatic",
            child: Widget.Box({
                vertical: true,
                spacing: 8,
                children: [
                    Widget.Box({
                        spacing: 16,
                        children: [
                            Widget.Label({
                                hexpand: true,
                                hpack: "start",
                                justification: "left",
                                label: "Bluetooth",
                            }),
                            Widget.Switch({
                                hexpand: false,
                                active: bluetooth.enabled,
                                setup: (self) =>
                                    self.on(
                                        "notify::active",
                                        () => (bluetooth.enabled = self.active)
                                    ),
                            }),
                        ],
                    }),
                    Widget.Box({
                        vertical: true,
                        spacing: 8,
                        children: bluetooth
                            .bind("devices")
                            .transform((devices) =>
                                devices
                                    .sort(
                                        (a, b) =>
                                            Number(b.connected) -
                                                Number(a.connected) ||
                                            Number(b.paired) -
                                                Number(a.paired) ||
                                            a.name.localeCompare(b.name)
                                    )
                                    .map(Device)
                            ),
                    }),
                ],
            }),
        }),
    });

export const toggleBluetooth = () => App.toggleWindow("bluetooth");

export default Bluetooth;
