import { toggleNotifications } from "../windows/notifications.js";
import { BELL, BELL_BADGE, BELL_OFF } from "../chars.js";

const notifications = await Service.import("notifications");

const Notifications = () =>
    Widget.Button({
        classNames: ["notifications", "icon"],
        onClicked: () => {
            toggleNotifications();
        },
    }).hook(notifications, (self) => {
        self.label = notifications.dnd
            ? BELL_OFF
            : notifications.notifications.length > 0
            ? BELL_BADGE
            : BELL;

        self.tooltip_text =
            notifications.notifications.length > 0
                ? `${notifications.notifications.length} notifications`
                : "No notifications";
    });

export default Notifications;
