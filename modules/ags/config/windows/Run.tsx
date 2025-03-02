import { Variable } from "astal";
import { App, Astal, Gdk, Gtk } from "astal/gtk3";
import Apps from "gi://AstalApps";
import { dismissPopup } from "../services/windows";

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
            app.launch();
        }}
    >
        {app.name}
    </button>
);

export default function Run() {
    let entry: Gtk.Entry;
    const appList = Variable([] as Apps.Application[]);

    return (
        <window
            name="run"
            className="run-window"
            anchor={
                Astal.WindowAnchor.BOTTOM |
                Astal.WindowAnchor.LEFT |
                Astal.WindowAnchor.RIGHT |
                Astal.WindowAnchor.TOP
            }
            layer={Astal.Layer.OVERLAY}
            keymode={Astal.Keymode.EXCLUSIVE}
            exclusivity={Astal.Exclusivity.IGNORE}
            visible={false}
            application={App}
            setup={(self) => {
                self.connect("notify::visible", () => {
                    if (!self.visible) {
                        entry.set_text("");
                        appList.set([]);
                    }
                });
            }}
        >
            <box valign={Gtk.Align.CENTER} halign={Gtk.Align.CENTER}>
                <box className="run-prompt" spacing={8} vertical>
                    <entry
                        onChanged={({ text }) =>
                            appList.set(apps.fuzzy_query(text))
                        }
                        setup={(self) => (entry = self)}
                    />
                    <scrollable
                        vscroll={Gtk.PolicyType.AUTOMATIC}
                        hscroll={Gtk.PolicyType.NEVER}
                        vexpand
                    >
                        <box spacing={8} vertical>
                            {appList().as((apps) =>
                                apps.map((app) => (
                                    <AppEntry app={app} close={dismissPopup} />
                                )),
                            )}
                        </box>
                    </scrollable>
                </box>
            </box>
        </window>
    );
}

export const toggleRun = () => App.toggle_window("run");
