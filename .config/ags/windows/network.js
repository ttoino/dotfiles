import AccessPoint from "../widgets/accesspoint.js";

const network = await Service.import("network");

const Wifi = () =>
    Widget.Box({
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
                        label: "Wifi",
                    }),
                    Widget.Switch({
                        hexpand: false,
                        active: network.wifi.bind("enabled"),
                    }),
                ],
            }),
            Widget.Box({
                vertical: true,
                spacing: 8,
                children: network.wifi
                    .bind("access_points")
                    .transform((aps) =>
                        aps
                            .sort(
                                (a, b) =>
                                    Number(b.active) - Number(a.active) ||
                                    b.strength - a.strength
                            )
                            .map(AccessPoint)
                    ),
            }),
        ],
    });

const Network = () =>
    Widget.Window({
        name: `network`,
        anchor: ["bottom", "right"],
        margins: [16],
        visible: false,
        child: Widget.Scrollable({
            classNames: ["network-window", "info-window"],
            vscroll: "automatic",
            hscroll: "never",
            child: Widget.Box({
                vertical: true,
                spacing: 16,
                children: [Wifi()],
            }),
        }),
    });

export const toggleNetwork = () => App.toggleWindow("network");

export default Network;
