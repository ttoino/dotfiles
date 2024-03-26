import Notification from "../widgets/notification.js";

const notifications = await Service.import("notifications");
const hyprland = await Service.import("hyprland");

print(notifications.forceTimeout, notifications.popupTimeout);

const Popups = (/** @type {number} */ monitor) => {
    /** @type {Record<number, ReturnType<Notification>>} */
    const popups = {};

    notifications.popups.forEach(
        (notification) => (popups[notification.id] = Notification(notification))
    );

    const list = Widget.Box({
        hexpand: true,
        vertical: true,
        spacing: 8,
        children: [...Object.values(popups)],
    })
        .hook(
            notifications,
            (self, /** @type {number} */ notificationId) => {
                if (notificationId in popups) {
                    popups[notificationId].destroy();
                    delete popups[notificationId];
                }

                if (monitor !== hyprland.active.monitor.id) return;

                const notification = notifications.getPopup(notificationId);

                if (!notification) return;

                const popup = Notification(notification);
                popups[notificationId] = popup;

                self.children = [popup, ...self.children];
            },
            "notified"
        )
        .hook(
            notifications,
            (self, /** @type {number} */ notificationId) => {
                if (notificationId in popups) {
                    popups[notificationId].destroy();
                    delete popups[notificationId];
                }
            },
            "dismissed"
        );

    return Widget.Window({
        monitor,
        name: `popups-${monitor}`,
        anchor: ["top", "right"],
        margins: [16],
        className: "popups-window",
        child: list,
    });
};

export default Popups;
