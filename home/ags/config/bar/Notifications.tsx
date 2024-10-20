import { Variable, bind } from "astal";
import Notifd from "gi://AstalNotifd";
import { BELL, BELL_BADGE, BELL_OFF } from "../lib/chars";
import IconButton from "../widgets/IconButton";
import { toggleNotifications } from "../windows/Notifications";

const notifications = Notifd.get_default();

const icon = Variable.derive(
    [bind(notifications, "dontDisturb"), bind(notifications, "notifications")],
    (dnd, notifications) =>
        dnd ? BELL_OFF : notifications.length > 0 ? BELL_BADGE : BELL
);
const tooltip = Variable.derive(
    [bind(notifications, "dontDisturb"), bind(notifications, "notifications")],
    (dnd, notifications) =>
        dnd
            ? "Do not disturb"
            : notifications.length > 0
            ? `${notifications.length} notifications`
            : "No notifications"
);

export default function Notifications() {
    return (
        <IconButton
            className="notifications"
            tooltipText={tooltip()}
            onClicked={toggleNotifications}
        >
            {icon()}
        </IconButton>
    );
}
