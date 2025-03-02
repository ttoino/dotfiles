import { bind } from "astal";
import { App, Astal, Gtk } from "astal/gtk3";
import { BELL, BELL_OFF, NOTIFICATION_CLEAR } from "../lib/chars";
import Notification from "../widgets/Notification";
import ToggleButton from "../widgets/ToggleButton";
import NotificationsProvider from "../providers/notifications";
import Renderer from "../lib/Renderer";
import IconButton from "../widgets/IconButton";
import { ascending } from "../lib/sorting";

const notifications = NotificationsProvider.get_default();

export default function Notifications() {
    const renderer = new Renderer<number>(
        (id) => {
            const notification = notifications.get(id);
            if (notification)
                return Notification(notification, () =>
                    notifications.dismiss(id),
                );
        },
        {
            initial: notifications.storage,
            sort: (a, b) =>
                ascending(
                    notifications.get(a)?.time ?? 0,
                    notifications.get(b)?.time ?? 0,
                ),
        },
    );

    notifications.connect("stored", (_, id) => renderer.add(id));
    notifications.connect("dismissed", (_, id) => renderer.delete(id));

    return (
        <window
            name="notifications"
            anchor={Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT}
            margin={16}
            visible={false}
            application={App}
        >
            <scrollable
                className="notifications-window info-window"
                hscroll={Gtk.PolicyType.NEVER}
                vscroll={Gtk.PolicyType.AUTOMATIC}
            >
                <box vertical spacing={8} valign={Gtk.Align.START}>
                    <box spacing={8}>
                        <label
                            hexpand
                            halign={Gtk.Align.START}
                            justify={Gtk.Justification.LEFT}
                            label="Notifications"
                        />
                        <IconButton
                            label={NOTIFICATION_CLEAR}
                            onClicked={() => notifications.dismissAll()}
                        />
                        <ToggleButton
                            className="icon"
                            active={bind(notifications, "dnd")}
                            label={bind(notifications, "dnd").as((dnd) =>
                                dnd ? BELL_OFF : BELL,
                            )}
                            onToggled={({ active }) =>
                                (notifications.dnd = active)
                            }
                        />
                    </box>
                    <box vertical spacing={8} noImplicitDestroy>
                        {bind(renderer).as((v) =>
                            v.length > 0 ? (
                                v
                            ) : (
                                <label label="No notifications" />
                            ),
                        )}
                    </box>
                </box>
            </scrollable>
        </window>
    );
}
