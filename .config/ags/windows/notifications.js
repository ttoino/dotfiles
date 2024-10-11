import { BELL, BELL_OFF, NOTIFICATION_CLEAR } from "../chars.js";
import Notification from "../widgets/notification.js";

const notifications = await Service.import("notifications");

const Notifications = () =>
    Widget.Window({
        name: `notifications`,
        anchor: ["bottom", "right"],
        margins: [16],
        visible: false,
        child: Widget.Scrollable({
            classNames: ["notifications-window", "info-window"],
            hscroll: "never",
            vscroll: "automatic",
            child: Widget.Box({
                vertical: true,
                spacing: 8,
                vpack: "start",
                children: [
                    Widget.Box({
                        spacing: 8,
                        children: [
                            Widget.Label({
                                hexpand: true,
                                hpack: "start",
                                justification: "left",
                                label: "Notifications",
                            }),
                            Widget.Button({
                                classNames: ["icon"],
                                label: NOTIFICATION_CLEAR,
                                onClicked: () => notifications.clear(),
                            }),
                            Widget.ToggleButton({
                                classNames: ["icon"],
                                active: notifications.bind("dnd"),
                                label: notifications
                                    .bind("dnd")
                                    .transform((dnd) =>
                                        dnd ? BELL_OFF : BELL
                                    ),
                                onToggled: ({ active }) =>
                                    (notifications.dnd = active),
                            }),
                        ],
                    }),
                    // @ts-ignore
                    Widget.Box({
                        vertical: true,
                        spacing: 8,
                        children: notifications
                            .bind("notifications")
                            .transform((notifications) =>
                                notifications.length > 0
                                    ? [...notifications]
                                          .reverse()
                                          .map(Notification)
                                    : [
                                          Widget.Label({
                                              vexpand: true,
                                              label: "No notifications",
                                              justification: "center",
                                          }),
                                      ]
                            ),
                    }),
                ],
            }),
        }),
    });

export const toggleNotifications = () => App.toggleWindow("notifications");

export default Notifications;
