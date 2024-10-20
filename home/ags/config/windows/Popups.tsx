import Notification from "../widgets/Notification";
import Notifd from "gi://AstalNotifd";
import Hyprland from "gi://AstalHyprland";
import { Astal, Gdk } from "astal/gtk3";

const notifications = Notifd.get_default();
const hyprland = Hyprland.get_default();

export default function Popups(monitor: Gdk.Monitor) {
    const popups = new Map<Number, JSX.Element>();

    return (
        <window
            gdkmonitor={monitor}
            name={`popups-${monitor.model}`}
            exclusivity={Astal.Exclusivity.IGNORE}
            anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
            margin={16}
        >
            <box
                hexpand
                vertical
                spacing={8}
                setup={(list) =>
                    list.hook(
                        notifications,
                        "notified",
                        (list, id: number, replaced: boolean) => {
                            if (
                                replaced ||
                                hyprland.focusedMonitor.model !== monitor.model
                            )
                                return;

                            const notification =
                                notifications.get_notification(id);
                            if (!notification) return;

                            const notificationWidget =
                                Notification(notification);
                            list.children.unshift(notificationWidget);
                            popups.set(id, notificationWidget);
                            notification.connect(
                                "dismissed",
                                (notification) => {
                                    popups.get(notification.id)?.destroy();
                                    popups.delete(notification.id);
                                }
                            );
                        }
                    )
                }
            />
        </window>
    );
}
