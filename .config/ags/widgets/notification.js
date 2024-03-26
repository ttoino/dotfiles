import { relativeTime } from "../utils.js";
import date from "../vars/date.js";
import IconSlider from "./iconslider.js";
import ScrollText from "./scrolltext.js";

const NotificationHeader = (
    /** @type {import("types/service/notifications").Notification} */ notification
) => {
    const hide = notification.hints["hide-header"]?.get_boolean();
    if (hide) return null;

    const children = [];

    if (notification.app_icon) {
        children.push(
            Widget.Icon({
                icon: notification.app_icon,
            })
        );
    }

    if (notification.app_name) {
        children.push(
            Widget.Label({
                label: notification.app_name,
                hpack: "start",
                hexpand: true,
                lines: 1,
                wrap: false,
            })
        );
    }

    children.push(
        Widget.Label({
            label: date
                .bind()
                .transform((date) =>
                    relativeTime(new Date(notification.time * 1000), date.date)
                ),
            tooltipText: notification.time.toString(),
            hpack: "end",
            hexpand: true,
            lines: 1,
            wrap: false,
        })
    );

    return children.length > 0
        ? Widget.Box({
              classNames: ["notification-app"],
              vexpand: true,
              hexpand: true,
              spacing: 4,
              children,
          })
        : null;
};

const NotificationBody = (
    /** @type {import("types/service/notifications").Notification} */ notification
) => {
    const hide = notification.hints["hide-body"]?.get_boolean();
    if (hide) return null;
    
    const children = [];

    if (notification.image) {
        children.push(
            Widget.Box({
                classNames: ["notification-image"],
                vpack: "start",
                css: `background-image: url("${notification.image}")`,
            })
        );
    }

    const innerChildren = [];

    if (notification.summary) {
        innerChildren.push(
            ScrollText({
                text: notification.summary,
                // hpack: "start",
                // hexpand: true,
                // lines: 1,
                // wrap: false,
            })
        );
    }

    if (notification.body) {
        innerChildren.push(
            Widget.Label({
                label: notification.body,
                hpack: "start",
                hexpand: true,
                lines: 4,
                wrap: true,
            })
        );
    }

    children.push(
        Widget.Box({
            vertical: true,
            vexpand: true,
            hexpand: true,
            spacing: 8,
            children: innerChildren,
        })
    );

    return Widget.Box({
        classNames: ["notification-body"],
        vexpand: true,
        hexpand: true,
        spacing: 8,
        children,
    });
};

const NotificationSlider = (
    /** @type {import("types/service/notifications").Notification} */ notification
) => {
    const value = notification.hints.value?.get_int32();
    if (value !== undefined && value !== null) {
        const icon = notification.hints["value-icon"]?.get_string()[0];

        if (icon && icon.length > 0)
            return IconSlider({
                drawValue: false,
                sensitive: false,
                min: 0,
                max: 100,
                value,
                icon,
                hexpand: true,
                setup: (slider) => {
                    slider.min = 0;
                    slider.max = 100;
                },
            })
        else
            return Widget.Slider({
                drawValue: false,
                sensitive: false,
                min: 0,
                max: 100,
                value,
                hexpand: true,
                setup: (slider) => {
                    slider.min = 0;
                    slider.max = 100;
                },
            });
    }

    return null;
};

const NotificationActions = (
    /** @type {import("types/service/notifications").Notification} */ notification
) => {
    const children = [];

    if (notification.actions) {
        for (const action of notification.actions) {
            children.push(
                Widget.Button({
                    label: action.label,
                    onClicked: () => notification.invoke(action.id),
                })
            );
        }
    }

    return children.length > 0
        ? Widget.Box({
              classNames: ["notification-actions"],
              spacing: 8,
              children,
          })
        : null;
};

const Notification = (
    /** @type {import("types/service/notifications").Notification} */ notification
) => {
    const classNames = notification.hints.classes?.get_strv() ?? [];

    const className = notification.hints["class"]?.get_string()[0];
    if (className) classNames.push(className);

    classNames.push(notification.urgency, "notification");

    return Widget.Box({
        classNames,
        vertical: true,
        // vexpand: true,
        hexpand: true,
        spacing: 8,
        children: [
            NotificationHeader(notification),
            NotificationBody(notification),
            NotificationSlider(notification),
            NotificationActions(notification),
        ].filter((a) => a !== null),
    });
};

export default Notification;
