import Brightness from "../../providers/brightness";
import { brightnessRange } from "../../lib/icons";
import { App } from "astal/gtk3";
import { notify } from "../../lib/notifications";

const brightness = Brightness.get_default();

let brightnessId: string | undefined;
brightness.connect("notify::screen-value", async () => {
    if (App.get_window("brightness")?.visible) return;

    const out = await notify({
        title: "Brightness",
        slider: {
            value: brightness.percentage * 100,
            icon: brightnessRange(brightness.percentage),
        },
        className: "brightness",
        id: brightnessId,
        hideBody: true,
        hideHeader: true,
    });

    if (!brightnessId) brightnessId = out.trim();
});

export {};
