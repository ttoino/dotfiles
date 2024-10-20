import { bind } from "astal";
import { App, Astal, Gtk } from "astal/gtk3";
import Notifd from "gi://AstalNotifd";
import { BELL, BELL_OFF, NOTIFICATION_CLEAR } from "../lib/chars";
import Notification from "../widgets/Notification";
import ToggleButton from "../widgets/ToggleButton";

const notifications = Notifd.get_default();

export default function Notifications() {
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
                        <button
                            className="icon"
                            label={NOTIFICATION_CLEAR}
                            // TODO
                            onClicked={() => {}}
                        />
                        <ToggleButton
                            className="icon"
                            active={bind(notifications, "dontDisturb")}
                            label={bind(notifications, "dontDisturb").as(
                                (dnd) => (dnd ? BELL_OFF : BELL)
                            )}
                            onToggled={({ active }) =>
                                (notifications.dontDisturb = active)
                            }
                        />
                    </box>
                    <box vertical spacing={8}>
                        {bind(notifications, "notifications").as(
                            (notifications) =>
                                notifications.length > 0
                                    ? [...notifications]
                                          .reverse()
                                          .map(Notification)
                                    : [
                                          <label
                                              vexpand
                                              label="No notifications"
                                              justify={Gtk.Justification.CENTER}
                                          />,
                                      ]
                        )}
                    </box>
                </box>
            </scrollable>
        </window>
    );
}

export const toggleNotifications = () => App.toggle_window("notifications");
