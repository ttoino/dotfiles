import { brightnessRange } from "../icons.js";
import brightness from "../services/brightness.js";
import IconSlider from "../widgets/iconslider.js";

const Brightness = () =>
    Widget.Window({
        name: "brightness",
        anchor: ["bottom", "right"],
        margins: [16],
        visible: false,
        child: Widget.Box({
            className: "slider-window",
            child: IconSlider({
                hexpand: true,
                drawValue: false,
                icon: brightness
                    .bind("screen_value")
                    .transform(brightnessRange),
                value: brightness.bind("screen_value"),
                step: 10,
                onChange: ({ value }) => (brightness.screen_value = value),
            }),
        }),
    });

export const toggleBrightness = () => App.toggleWindow("brightness");

export default Brightness;
