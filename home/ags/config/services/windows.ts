import { Variable } from "astal";
import { App, Gdk } from "astal/gtk3";
import { Window } from "astal/gtk3/widget";
import Audio from "../windows/Audio";
import Bar from "../windows/Bar";
import Battery from "../windows/Battery";
import Bluetooth from "../windows/Bluetooth";
import Brightness from "../windows/Brightness";
import Calendar from "../windows/Calendar";
import Dismisser from "../windows/Dismisser";
import Media from "../windows/Media";
import Network from "../windows/Network";
import Popups from "../windows/Popups";
import Power from "../windows/Power";
import Run from "../windows/Run";
import Scrim from "../windows/Scrim";

const WINDOWS = [Bar, Popups] as const;

const POPUP_WINDOWS = [
    Audio,
    Battery,
    Bluetooth,
    Brightness,
    Calendar,
    Media,
    Network,
    // Notifications,
] as const;

const SCRIMMED_POPUP_WINDOWS = [Power, Run] as const;

const popups = new Map<string, Window>();
const scrimmedPopups = new Map<string, Window>();

const dismissers = new Set<Window>();
const scrims = new Set<Window>();

const perMonitor = new Map<Gdk.Monitor, Window[]>();

const visible = Variable<string | null>(null);
const dismisserVisible = Variable.derive([visible], (v) => !!v);
const scrimVisible = Variable.derive(
    [visible],
    (v) => !!(v && scrimmedPopups.has(v))
);

dismisserVisible.subscribe((v) => {
    if (!v) dismissers.forEach((w) => (w.visible = false));
});
scrimVisible.subscribe((v) => {
    if (!v) scrims.forEach((w) => (w.visible = false));
});

export const dismissPopup = () => {
    visible.set(null);
};

export const showPopup = (name: string) => {
    visible.set(name);
};

export const togglePopup = (name: string) => {
    if (visible.get() === name) dismissPopup();
    else showPopup(name);
};

export const init = () => {
    const createWindows = (monitor: Gdk.Monitor) => {
        const dismisser = Dismisser(monitor) as Window;
        dismissers.add(dismisser);

        const scrim = Scrim(monitor) as Window;
        scrims.add(scrim);

        perMonitor.set(monitor, [
            dismisser,
            scrim,
            ...WINDOWS.map((fn) => fn(monitor) as Window),
        ]);
    };

    App.get_monitors().forEach(createWindows);
    App.connect("monitor-added", (_, monitor) => createWindows(monitor));
    App.connect("monitor-removed", (_, monitor) => {
        perMonitor.get(monitor)?.forEach((w) => {
            dismissers.delete(w);
            scrims.delete(w);
            w.destroy();
        });
        perMonitor.delete(monitor);
    });

    POPUP_WINDOWS.forEach((fn) => {
        const popup = fn() as Window;
        popups.set(popup.name, popup);
        visible().subscribe((v) => {
            const visible = v === popup.name;

            if (visible) dismissers.forEach((w) => (w.visible = true));

            popup.visible = visible;
        });
        popup.connect("notify::visible", () => {
            if (popup.visible) visible.set(popup.name);
            else if (visible.get() === popup.name) visible.set(null);
        });
    });

    SCRIMMED_POPUP_WINDOWS.forEach((fn) => {
        const popup = fn() as Window;
        scrimmedPopups.set(popup.name, popup);
        visible().subscribe((v) => {
            const visible = v === popup.name;

            if (visible) {
                dismissers.forEach((w) => (w.visible = true));
                scrims.forEach((w) => (w.visible = true));
            }

            popup.visible = visible;
        });
        popup.connect("notify::visible", () => {
            if (popup.visible) visible.set(popup.name);
            else if (visible.get() === popup.name) visible.set(null);
        });
    });
};
