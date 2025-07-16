import NetworkService from "gi://AstalNetwork";
import { ETHERNET, SEPARATOR, WEB_OFF } from "../lib/chars";
import { wifiRange } from "../lib/icons";
import IconButton from "../widgets/IconButton";
import { togglePopup } from "../services/windows";
import { createBinding, createComputed } from "ags";

const network = NetworkService.get_default();

const icons = createComputed(
    [
        // bind(network.wired, "state"),
        createBinding(network.wifi, "state"),
        createBinding(network.wifi, "strength"),
    ],
    (
        // wired,
        wifi,
        wifiStrength,
    ) => {
        const icons = [];

        // if (wired == NetworkService.DeviceState.ACTIVATED) icons.push(ETHERNET);
        if (wifi == NetworkService.DeviceState.ACTIVATED)
            icons.push(wifiRange(wifiStrength));
        if (icons.length === 0) icons.push(WEB_OFF);

        return icons.join();
    },
);
const tooltip = createComputed(
    [
        // bind(network.wired, "state"),
        createBinding(network.wifi, "state"),
        createBinding(network.wifi, "ssid"),
        createBinding(network.wifi, "strength"),
    ],
    (
        // wired,
        wifi,
        ssid,
        strength,
    ) => {
        const parts = [];

        // if (wired == NetworkService.DeviceState.ACTIVATED)
        // parts.push("Ethernet");
        if (wifi == NetworkService.DeviceState.ACTIVATED)
            parts.push(ssid, strength + "%");
        if (parts.length === 0) parts.push("No network");

        return parts.join(` ${SEPARATOR} `);
    },
);

export default function Network() {
    return (
        <IconButton
            class="network"
            tooltipText={tooltip}
            onClicked={() => togglePopup("network")}
            label={icons}
        />
    );
}
