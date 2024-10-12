import brightness from "../services/brightness.js";
import { brightnessRange } from "../icons.js";
import { toggleBrightness } from "../windows/brightness.js";

const Brightness = () =>
    Widget.Button({
        classNames: ["icon", "brightness"],
        onClicked: () => toggleBrightness(),
    }).hook(brightness, (self) => {
        self.label = brightnessRange(brightness.screen_value);

        self.tooltip_text = Math.round(brightness.screen_value * 100) + "%";
    });

export default Brightness;
