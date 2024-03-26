import { batteryRange } from "../icons.js";
import IconSlider from "../widgets/iconslider.js";

const battery = await Service.import("battery");

const Battery = () =>
    Widget.Window({
        name: "battery",
        anchor: ["bottom", "right"],
        margins: [16],
        visible: false,
        child: Widget.Box({
            className: "slider-window",
            child: IconSlider({
                hexpand: true,
                drawValue: false,
                sensitive: false,
            }).hook(battery, (self) => {
                self.icon = batteryRange(battery.charging, battery.percent);
                self.value = battery.percent / 100;
            }),
        }),
    }).hook(battery, (self) => {
        self.toggleClassName("discharging", !battery.charging);
        self.toggleClassName("critical", battery.percent <= 15);
    });

export const toggleBattery = () => App.toggleWindow("battery");

export default Battery;
