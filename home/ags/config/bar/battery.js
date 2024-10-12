import { toggleBattery } from "../windows/battery.js";
import { SEPARATOR } from "../chars.js";
import { batteryRange } from "../icons.js";

const battery = await Service.import("battery");

const Battery = () =>
    Widget.Button({
        classNames: ["icon", "battery"],
        onClicked: () => toggleBattery(),
    }).hook(battery, (self) => {
        self.label = batteryRange(battery.charging, battery.percent);

        self.tooltip_text =
            battery.percent +
            "%" +
            (battery.charging ? ` ${SEPARATOR} Charging` : "");
    });

export default Battery;
