import { bind } from "astal";
import { App, Astal } from "astal/gtk3";
import { brightnessRange } from "../lib/icons";
import BrightnessService from "../providers/brightness";
import IconSlider from "../widgets/IconSlider";

const brightness = BrightnessService.get_default();

export default function Brightness() {
    return (
        <window
            name="brightness"
            anchor={Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT}
            margin={16}
            visible={false}
            application={App}
        >
            <box className="slider-window">
                <IconSlider
                    hexpand
                    drawValue={false}
                    icon={bind(brightness, "percentage").as(brightnessRange)}
                    value={bind(brightness, "percentage")}
                    step={10}
                    onDragged={({ value }) => (brightness.percentage = value)}
                />
            </box>
        </window>
    );
}

export const toggleBrightness = () => App.toggle_window("brightness");
