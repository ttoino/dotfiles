import brightness from "../brightness.js";
import { brightnessRange } from "../../icons.js";
import { sendSliderNotification } from "./slider.js";

let brightnessId = undefined;
brightness.connect("notify::screen-value", async () => {
    if (App.getWindow("brightness")?.visible) return;

    const out = await sendSliderNotification(
        brightness.screen_value * 100,
        brightnessRange(brightness.screen_value),
        "Brightness",
        "brightness",
        brightnessId
    );

    if (!brightnessId) brightnessId = out.trim();
});

export {};
