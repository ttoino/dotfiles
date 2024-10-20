import Network from "gi://AstalNetwork";
import { wifiRange } from "../lib/icons.js";
import Icon from "./Icon.js";

export default function AccessPoint({
    ap,
    active,
}: {
    ap: Network.AccessPoint;
    active: boolean;
}) {
    return (
        <box className={`access-point ${active ? "active" : ""}`} spacing={16}>
            <Icon className="strength" label={wifiRange(ap.strength)} />
            <label>{ap.ssid}</label>
        </box>
    );
}
