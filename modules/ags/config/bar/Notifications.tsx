import { BELL, BELL_BADGE, BELL_OFF } from "../lib/chars";
import IconButton from "../widgets/IconButton";
import { togglePopup } from "../services/windows";
import NotificationsProvider from "../providers/notifications";
import { createBinding, createComputed, createState } from "ags";

const notifications = NotificationsProvider.get_default();

const count = createBinding(notifications, "storage").as(
    (storage) => storage.length,
);

const icon = createComputed(
    [createBinding(notifications, "dnd"), count],
    (dnd, count) => (dnd ? BELL_OFF : count > 0 ? BELL_BADGE : BELL),
);
const tooltip = createComputed(
    [createBinding(notifications, "dnd"), count],
    (dnd, count) =>
        dnd
            ? "Do not disturb"
            : count > 0
              ? `${count} notifications`
              : "No notifications",
);

export default function Notifications() {
    return (
        <IconButton
            class="notifications"
            tooltipText={tooltip}
            onClicked={() => togglePopup("notifications")}
            label={icon}
        />
    );
}
