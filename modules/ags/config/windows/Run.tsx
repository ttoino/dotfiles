import Apps from "gi://AstalApps";
import { dismissPopup } from "../services/windows";
import { Astal, Gtk } from "ags/gtk4";
import { createState, For } from "ags";
import app from "ags/gtk4/app";
import { execAsync } from "ags/process";

const apps = new Apps.Apps();

const AppEntry = ({
    app,
    close,
}: {
    app: Apps.Application;
    close: () => void;
}) => (
    <button
        onClicked={() => {
            close();
            if (app.categories.includes("ConsoleOnly"))
                execAsync(["uwsm", "app", "-T", app.entry]);
            else execAsync(["uwsm", "app", app.entry]);
        }}
    >
        {app.name}
    </button>
);

export default function Run(props: Partial<JSX.IntrinsicElements["window"]>) {
    let entry: Gtk.Entry;
    const [appList, setAppList] = createState([] as Apps.Application[]);

    return (
        <window
            name="run"
            class="run-window"
            anchor={
                Astal.WindowAnchor.BOTTOM |
                Astal.WindowAnchor.LEFT |
                Astal.WindowAnchor.RIGHT |
                Astal.WindowAnchor.TOP
            }
            layer={Astal.Layer.OVERLAY}
            keymode={Astal.Keymode.EXCLUSIVE}
            exclusivity={Astal.Exclusivity.IGNORE}
            application={app}
            {...props}
            $={(self) => {
                self.connect("notify::visible", () => {
                    if (!self.visible) {
                        entry.set_text("");
                        setAppList([]);
                    }
                });

                props.$?.(self);
            }}
        >
            <box valign={Gtk.Align.CENTER} halign={Gtk.Align.CENTER}>
                <box
                    class="run-prompt"
                    spacing={8}
                    orientation={Gtk.Orientation.VERTICAL}
                >
                    <entry
                        onNotifyText={({ text }) =>
                            setAppList(apps.fuzzy_query(text))
                        }
                        $={(self) => (entry = self)}
                    />
                    <scrolledwindow
                        vscrollbarPolicy={Gtk.PolicyType.AUTOMATIC}
                        hscrollbarPolicy={Gtk.PolicyType.NEVER}
                        vexpand
                    >
                        <box spacing={8} orientation={Gtk.Orientation.VERTICAL}>
                            <For each={appList}>
                                {(app) => (
                                    <AppEntry app={app} close={dismissPopup} />
                                )}
                            </For>
                        </box>
                    </scrolledwindow>
                </box>
            </box>
        </window>
    );
}
