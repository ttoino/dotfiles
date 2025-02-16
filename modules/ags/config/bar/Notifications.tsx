import { Variable, bind } from "astal";
import { BELL, BELL_BADGE, BELL_OFF } from "../lib/chars";
import IconButton from "../widgets/IconButton";
import { togglePopup } from "../services/windows";
import NotificationsProvider from "../providers/notifications";

const notifications = NotificationsProvider.get_default();

const count = Variable(notifications.storage.length);

notifications.connect("stored", () => count.set(notifications.storage.length));
notifications.connect("dismissed", () => count.set(notifications.storage.length));

const icon = Variable.derive(
    [bind(notifications, "dnd"), count],
    (dnd, count) =>
        dnd ? BELL_OFF : count > 0 ? BELL_BADGE : BELL
);
const tooltip = Variable.derive(
    [bind(notifications, "dnd"), count],
    (dnd, count) =>
        dnd
            ? "Do not disturb"
            : count > 0
            ? `${count} notifications`
            : "No notifications"
);

export default function Notifications() {
    return (
        <IconButton
            className="notifications"
            tooltipText={tooltip()}
            onClicked={() => togglePopup("notifications")}
        >
            {icon()}
        </IconButton>
    );
}
