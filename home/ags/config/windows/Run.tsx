import { App, Astal, Gdk, Gtk } from "astal/gtk3";
import { bind, Variable } from "astal";
import Apps from "gi://AstalApps";

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

    const close = () => {
        toggleRun();
        entry.set_text("");
        appList.set([]);
    };

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
            // TODO: This is bugged rn, ON_DEMAND and EXCLUSIVE are swapped
            keymode={Astal.Keymode.ON_DEMAND}
            visible={false}
            application={App}
            onKeyPressEvent={(self, event) => {
                const [result, keyval] = event.get_keyval();
                if (!result) return;

                if (keyval == Gdk.KEY_Escape) return close();
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
                                    <AppEntry app={app} close={close} />
                                ))
                            )}
                        </box>
                    </scrollable>
                </box>
            </box>
        </window>
    );
}

export const toggleRun = () => App.toggle_window("run");
