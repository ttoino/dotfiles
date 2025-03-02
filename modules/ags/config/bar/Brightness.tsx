import { bind } from "astal";
import { brightnessRange } from "../lib/icons";
import BrightnessService from "../providers/brightness";
import IconButton from "../widgets/IconButton";
import { togglePopup } from "../services/windows";

const brightness = BrightnessService.get_default();

export default function Brightness() {
    return (
        <IconButton
            className="brightness"
            tooltipText={bind(brightness, "percentage").as(
                (p) => `${Math.round(p * 100)}%`,
            )}
            onClicked={() => togglePopup("brightness")}
        >
            {bind(brightness, "percentage").as((p) => brightnessRange(p))}
        </IconButton>
    );
}
