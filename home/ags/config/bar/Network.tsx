import { Variable, bind } from "astal";
import NetworkService from "gi://AstalNetwork";
import { ETHERNET, SEPARATOR, WEB_OFF } from "../lib/chars";
import { wifiRange } from "../lib/icons";
import IconButton from "../widgets/IconButton";
import { toggleNetwork } from "../windows/Network";

const network = NetworkService.get_default();

const icons = Variable.derive(
    [
        // bind(network.wired, "state"),
        // bind(network.wifi, "state"),
        // bind(network.wifi, "strength"),
    ],
    () =>
        // wired,
        // wifi,
        // wifiStrength
        {
            const icons = [];

            // if (wired == NetworkService.DeviceState.ACTIVATED) icons.push(ETHERNET);
            // if (wifi == NetworkService.DeviceState.ACTIVATED)
            // icons.push(wifiRange(wifiStrength));
            if (icons.length === 0) icons.push(WEB_OFF);

            return icons;
        }
);
const tooltip = Variable.derive(
    [
        // bind(network.wired, "state"),
        // bind(network.wifi, "state"),
        // bind(network.wifi, "ssid"),
        // bind(network.wifi, "strength"),
    ],
    () =>
        //  wired,
        // wifi,
        // ssid,
        // strength
        {
            const parts = [];

            // if (wired == NetworkService.DeviceState.ACTIVATED)
            // parts.push("Ethernet");
            // if (wifi == NetworkService.DeviceState.ACTIVATED)
            // parts.push(ssid, strength + "%");
            if (parts.length === 0) parts.push("No network");

            return parts.join(` ${SEPARATOR} `);
        }
);

export default function Network() {
    return (
        <IconButton
            className="network"
            tooltipText={tooltip()}
            onClicked={toggleNetwork}
        >
            <box>{icons()}</box>
        </IconButton>
    );
}
