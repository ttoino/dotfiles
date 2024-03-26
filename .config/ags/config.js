import Popups from "./windows/popups.js";
import Bar from "./windows/bar.js";
import Network from "./windows/network.js";
import Bluetooth from "./windows/bluetooth.js";
import Notifications from "./windows/notifications.js";
import Audio from "./windows/audio.js";
import Calendar from "./windows/calendar.js";
import Brightness from "./windows/brightness.js";
import Battery from "./windows/battery.js";
import "./services/notifications/index.js";

/** @type {((monitor: number) => import("types/widgets/window.js").Window)[]} */
const windows = [Bar, Popups];

Utils.monitorFile(`${App.configDir}/style`, () => {
    Utils.exec(
        `sass ${App.configDir}/style/main.scss ${App.configDir}/style.css`
    );
    App.resetCss();
    App.applyCss(`${App.configDir}/style.css`);
});

const hyprland = await Service.import("hyprland");

/** @type {Map<string, number>} */
const monitors = new Map();

const id = hyprland.connect("notify::monitors", (hyprland) => {
    hyprland.monitors.forEach((monitor) => {
        windows.forEach((window) => App.addWindow(window(monitor.id)));
        monitors.set(monitor.name, monitor.id);
    });
    hyprland.disconnect(id);
});

hyprland.connect("monitor-added", (hyprland, monitor) => {
    print("monitor-added", monitor);
    windows.forEach((window) => App.addWindow(window(monitor.id)));
});

hyprland.connect("monitor-removed", (_, monitor) => {
    print("monitor-removed", monitor);
    App.windows.forEach((window) => {
        if (window.name?.endsWith(`-${monitor}`)) App.removeWindow(window);
    });
});

Utils.exec(`sass ${App.configDir}/style/main.scss ${App.configDir}/style.css`);

App.config({
    style: "./style.css",
    windows: [
        Audio(),
        Battery(),
        Bluetooth(),
        Brightness(),
        Calendar(),
        Network(),
        Notifications(),
    ],
});
