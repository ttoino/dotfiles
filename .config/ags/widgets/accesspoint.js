import { wifiRange } from "../icons.js";

const AccessPoint = (
    /** @type {import("types/service/network").Wifi["access_points"][number]} */ ap
) =>
    Widget.Box({
        classNames: ["access-point", ap.active ? "active" : ""],
        spacing: 16,
        children: [
            Widget.Label({
                classNames: ["icon", "strength"],
                label: wifiRange(ap.strength),
            }),
            Widget.Label({ label: ap.ssid }),
        ],
    });

export default AccessPoint;
