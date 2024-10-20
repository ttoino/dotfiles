import { Variable, bind } from "astal";
import BatteryService from "gi://AstalBattery";
import { SEPARATOR } from "../lib/chars";
import { batteryRange } from "../lib/icons";
import IconButton from "../widgets/IconButton";
import { toggleBattery } from "../windows/Battery";

const battery = BatteryService.get_default();

const icon = Variable.derive(
    [bind(battery, "charging"), bind(battery, "percentage")],
    (charging, percent) => batteryRange(charging, percent)
);
const tooltip = Variable.derive(
    [bind(battery, "charging"), bind(battery, "percentage")],
    (charging, percent) => {
        const parts = [percent * 100 + "%"];

        if (charging) parts.push("Charging");

        return parts.join(` ${SEPARATOR} `);
    }
);

export default function Battery() {
    return (
        <IconButton
            className="battery"
            tooltipText={tooltip()}
            onClicked={toggleBattery}
        >
            {icon()}
        </IconButton>
    );
}
