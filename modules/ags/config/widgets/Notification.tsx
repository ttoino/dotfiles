import { urgencyToString } from "../lib/notifications";
import { relativeTime } from "../lib/time";
import date from "../providers/date";
import IconSlider from "./IconSlider";
import ScrollText from "./ScrollText";
import IconButton from "./IconButton";
import { CLOSE } from "../lib/chars";
import { Notification as NotificationObject } from "../providers/notifications";
import { Gtk } from "ags/gtk4";

const NotificationHeader = (
    notification: NotificationObject,
    onDismiss: () => void,
    popup: boolean,
) =>
    !notification.hideHeader && (
        <box class="notification-app" vexpand hexpand spacing={4}>
            {notification.appIcon && <image iconName={notification.appIcon} />}
            {notification.appName && (
                <label
                    label={notification.appName}
                    halign={Gtk.Align.START}
                    hexpand
                    lines={1}
                    wrap={false}
                />
            )}
            {!popup && (
                <>
                    <label
                        label={date.as((date) =>
                            relativeTime(
                                new Date(notification.time * 1000),
                                date.date,
                            ),
                        )}
                        tooltipText={new Date(notification.time).toString()}
                        halign={Gtk.Align.END}
                        hexpand
                        lines={1}
                        wrap={false}
                    />
                    <IconButton
                        label={CLOSE}
                        onClicked={onDismiss}
                        tooltipText="Dismiss"
                        class="sm"
                    />
                </>
            )}
        </box>
    );

const NotificationBody = (notification: NotificationObject) =>
    !notification.hideBody && (
        <box class="notification-body" vexpand hexpand spacing={8}>
            {notification.image && (
                <box
                    class="notification-image"
                    valign={Gtk.Align.START}
                    css={`
                        background-image: url("${notification.image}");
                    `}
                />
            )}
            <box
                orientation={Gtk.Orientation.VERTICAL}
                vexpand
                hexpand
                spacing={8}
            >
                {notification.summary && (
                    <ScrollText
                        labelProps={{ halign: Gtk.Align.START }}
                        label={notification.summary}
                    />
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

const NotificationSlider = (notification: NotificationObject) => {
    const value = notification.sliderValue;
    if (value == undefined) return;

    const icon = notification.sliderIcon;

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

const NotificationActions = (notification: NotificationObject) => {
    return (
        notification.actions?.length > 0 && (
            <box class="notification-actions" spacing={8}>
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

export default function Notification(
    notification: NotificationObject,
    onDismiss: () => void,
    popup = false,
) {
    return (
        <box
            class={`${notification.className} ${urgencyToString[notification.urgency]} notification`}
            orientation={Gtk.Orientation.VERTICAL}
            valign={Gtk.Align.START}
            hexpand
            spacing={8}
        >
            {NotificationHeader(notification, onDismiss, popup)}
            {NotificationBody(notification)}
            {NotificationSlider(notification)}
            {NotificationActions(notification)}
        </box>
    );
}
