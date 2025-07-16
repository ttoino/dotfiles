import app from "ags/gtk4/app";
import { brightnessRange } from "../lib/icons";
import BrightnessService from "../providers/brightness";
import IconSlider from "../widgets/IconSlider";
import { Astal } from "ags/gtk4";
import { createBinding } from "ags";

const brightness = BrightnessService.get_default();

export default function Brightness(
    props: Partial<JSX.IntrinsicElements["window"]>,
) {
    return (
        <window
            name="brightness"
            anchor={Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT}
            margin={16}
            visible={false}
            application={app}
            {...props}
        >
            <box class="slider-window">
                <IconSlider
                    hexpand
                    drawValue={false}
                    icon={createBinding(brightness, "percentage").as(
                        brightnessRange,
                    )}
                    value={createBinding(brightness, "percentage")}
                    step={10}
                    onNotifyValue={({ value }) =>
                        (brightness.percentage = value)
                    }
                />
            </box>
        </window>
    );
}
