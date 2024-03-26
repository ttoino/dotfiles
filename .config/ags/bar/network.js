import { ETHERNET, SEPARATOR, WEB_OFF } from "../chars.js";
import { toggleNetwork } from "../windows/network.js";
import { wifiRange } from "../icons.js";

const network = await Service.import("network");

const Network = () =>
    Widget.Button({
        classNames: ["icon", "network"],
        child: Widget.Box({
            spacing: 4,
        }),
        onClicked: () => {
            network.wifi.scan();
            toggleNetwork();
        },
    }).hook(network, (self) => {
        const icons = [];
        const tooltipParts = [];

        if (network.wired.state === "activated") {
            icons.push(ETHERNET);
            tooltipParts.push("Ethernet");
        }

        if (network.wifi.state === "activated") {
            icons.push(wifiRange(network.wifi.strength));
            tooltipParts.push(network.wifi.ssid, network.wifi.strength + "%");
        }

        if (icons.length === 0) icons.push(WEB_OFF);
        if (tooltipParts.length === 0) tooltipParts.push("No network");

        self.tooltip_text = tooltipParts.join(` ${SEPARATOR} `);

        self.child.children = icons.map((icon) =>
            Widget.Label({ label: icon })
        );
    });

export default Network;
