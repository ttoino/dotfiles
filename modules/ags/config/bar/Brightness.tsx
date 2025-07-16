import { brightnessRange } from "../lib/icons";
import BrightnessService from "../providers/brightness";
import IconButton from "../widgets/IconButton";
import { togglePopup } from "../services/windows";
import { createBinding } from "ags";

const brightness = BrightnessService.get_default();

export default function Brightness() {
    return (
        <IconButton
            class="brightness"
            tooltipText={createBinding(brightness, "percentage").as(
                (p) => `${Math.round(p * 100)}%`,
            )}
            onClicked={() => togglePopup("brightness")}
            label={createBinding(brightness, "percentage").as((p) =>
                brightnessRange(p),
            )}
        />
    );
}
