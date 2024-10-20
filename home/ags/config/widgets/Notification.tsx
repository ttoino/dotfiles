import { Gtk } from "astal/gtk3";
import Notifd from "gi://AstalNotifd";
import { urgencyToString } from "../lib/notifications";
import { relativeTime } from "../lib/time";
import date from "../providers/date";
import IconSlider from "./IconSlider";
import ScrollText from "./ScrollText";

const NotificationHeader = (notification: Notifd.Notification) =>
    !notification.get_bool_hint("hide-header") && (
        <box className="notification-app" vexpand hexpand spacing={4}>
            {notification.appIcon && <icon icon={notification.appIcon} />}
            {notification.appName && (
                <label
                    label={notification.appName}
                    halign={Gtk.Align.START}
                    hexpand
                    lines={1}
                    wrap={false}
                />
            )}
            <label
                label={date().as((date) =>
                    relativeTime(new Date(notification.time * 1000), date.date)
                )}
                tooltipText={notification.time.toString()}
                halign={Gtk.Align.END}
                hexpand
                lines={1}
                wrap={false}
            />
        </box>
    );

const NotificationBody = (notification: Notifd.Notification) =>
    !notification.get_bool_hint("hide-body") && (
        <box className="notification-body" vexpand hexpand spacing={8}>
            {notification.image && (
                <box
                    className="notification-image"
                    valign={Gtk.Align.START}
                    css={`
                        background-image: url("${notification.image}");
                    `}
                />
            )}
            <box vertical vexpand hexpand spacing={8}>
                {notification.summary && (
                    <ScrollText label={notification.summary} />
                )}
                {notification.body && (
                    <label
                        halign={Gtk.Align.START}
                        hexpand
                        lines={4}
                        wrap
                        label={notification.body}
                    />
                )}
            </box>
        </box>
    );

const NotificationSlider = (notification: Notifd.Notification) => {
    const value = notification.get_int_hint("value");
    if (value == undefined) return;

    const icon = notification.get_str_hint("value-icon");

    return icon && icon.length > 0 ? (
        <IconSlider
            drawValue={false}
            sensitive={false}
            min={0}
            max={100}
            value={value}
            icon={icon}
            hexpand
        />
    ) : (
        <slider
            drawValue={false}
            sensitive={false}
            min={0}
            max={100}
            value={value}
            hexpand
        />
    );
};

const NotificationActions = (notification: Notifd.Notification) => {
    return (
        notification.actions && (
            <box className="notification-actions" spacing={8}>
                {notification.actions.map((action) => (
                    <button
                        label={action.label}
                        onClicked={() => notification.invoke(action.id)}
                    />
                ))}
            </box>
        )
    );
};

export default function Notification(notification: Notifd.Notification) {
    const classNames = notification.get_hint("classes")?.get_strv() ?? [];

    const className = notification.get_str_hint("class");
    if (className) classNames.push(className);

    classNames.push(urgencyToString[notification.urgency], "notification");

    return (
        <box
            className={classNames.join(" ")}
            vertical
            valign={Gtk.Align.START}
            hexpand
            spacing={8}
        >
            {NotificationHeader(notification)}
            {NotificationBody(notification)}
            {NotificationSlider(notification)}
            {NotificationActions(notification)}
        </box>
    );
}
