import { App, Gdk, Gtk } from "astal/gtk3";
import style from "./style/main.scss";
import Audio from "./windows/Audio";
import Bar from "./windows/Bar";
import Battery from "./windows/Battery";
import Bluetooth from "./windows/Bluetooth";
import Brightness from "./windows/Brightness";
import Calendar from "./windows/Calendar";
import Media from "./windows/Media";
import Network from "./windows/Network";
import Notifications from "./windows/Notifications";
import Popups from "./windows/Popups";
import "./services/notifications";

App.start({
    css: style,
    main() {
        // Windows with one instance per monitor
        const windowFunctions = [Bar, Popups] as const;
        const windows = new Map<Gdk.Monitor, Gtk.Widget[]>();

        const createWindows = (monitor: Gdk.Monitor) => {
            windows.set(
                monitor,
                windowFunctions.map((fn) => fn(monitor))
            );
        };

        App.get_monitors().forEach(createWindows);
        App.connect("monitor-added", (_, monitor) => createWindows(monitor));
        App.connect("monitor-removed", (_, monitor) => {
            windows.get(monitor)?.forEach((w) => w.destroy());
            windows.delete(monitor);
        });

        // Windows with only one instance
        Audio();
        Battery();
        Bluetooth();
        Brightness();
        Calendar();
        Media();
        Network();
        Notifications();
    },
});
