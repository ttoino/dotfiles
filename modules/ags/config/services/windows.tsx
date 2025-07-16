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
import Notifications from "../windows/Notifications";
import { createBinding, createComputed, createState, For } from "ags";
import app from "ags/gtk4/app";
import { Astal, Gdk, Gtk } from "ags/gtk4";

const WINDOWS = [Bar, Popups] as const;

const POPUP_WINDOWS = [
    Audio,
    Battery,
    Bluetooth,
    Brightness,
    Calendar,
    Media,
    Network,
    Notifications,
] as const;

const SCRIMMED_POPUP_WINDOWS = [Power, Run] as const;

const scrimmedPopups = new Set<string>();

const [visible, setVisible] = createState<string | null>(null);
const dismisserVisible = visible.as((v) => !!v);
const scrimVisible = visible.as((v) => !!v && scrimmedPopups.has(v));

export const dismissPopup = () => setVisible(null);

export const showPopup = (name: string) => setVisible(name);

export const togglePopup = (name: string) => {
    if (visible.get() === name) dismissPopup();
    else showPopup(name);
};

const tryRender =
    <Props extends Partial<JSX.IntrinsicElements["window"]>>(
        fn: (props: Props) => JSX.Element,
    ): ((props: Props) => JSX.Element) =>
    (props) => {
        try {
            return fn(props);
        } catch (e) {
            console.error(`Error rendering window: ${e}`);
            console.error(e.stack);
            return (
                <window
                anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT}
                    visible
                    application={app}
                    {...props}
                >
                    <label label={`Error rendering window: ${e}`} />
                </window>
            );
        }
    };

export const init = () => {
    const monitors = createBinding(app, "monitors");

    <For each={monitors} cleanup={(win) => (win as Gtk.Window).destroy()}>
        {(monitor) =>
            tryRender(Dismisser)({
                gdkmonitor: monitor,
                visible: dismisserVisible,
            })
        }
    </For>;

    <For each={monitors} cleanup={(win) => (win as Gtk.Window).destroy()}>
        {(monitor) =>
            tryRender(Scrim)({
                gdkmonitor: monitor,
                visible: scrimVisible,
            })
        }
    </For>;

    WINDOWS.map((Window) => (
        <For each={monitors} cleanup={(win) => (win as Gtk.Window)?.destroy()}>
            {(monitor) =>
                tryRender(Window)({
                    gdkmonitor: monitor,
                    visible: true,
                })
            }
        </For>
    ));

    const renderWindow =
        (scrimmed: boolean) =>
        (
            Window:
                | (typeof POPUP_WINDOWS)[number]
                | (typeof SCRIMMED_POPUP_WINDOWS)[number],
        ) => {
            let window: Gtk.Window;

            return tryRender(Window)({
                visible: visible.as(
                    (v) => (window && v === window.name) ?? false,
                ),
                $: (w) => {
                    window = w;

                    if (scrimmed) scrimmedPopups.add(window.name);

                    createBinding(window, "visible").subscribe(() => {
                        if (window.visible) setVisible(window.name);
                        else if (visible.get() === window.name)
                            setVisible(null);
                    });
                },
            });
        };

    POPUP_WINDOWS.map(renderWindow(false));
    SCRIMMED_POPUP_WINDOWS.map(renderWindow(true));
};
