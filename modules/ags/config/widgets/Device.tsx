import Icon from "./Icon";
import { accessor } from "../lib/vars";
import { Accessor, createComputed, With } from "ags";
import { Gtk } from "ags/gtk4";

export interface DeviceProps {
    title?: string | Accessor<string | undefined>;
    subtitle?: string | Accessor<string | undefined>;
    icon?: string | Accessor<string | undefined>;
    iconTooltip?: string | Accessor<string | undefined>;
    active?: boolean | Accessor<boolean | undefined>;
    activating?: boolean | Accessor<boolean | undefined>;

    onPrimaryClick?(): void;
    onSecondaryClick?(): void;
}

export default function Device({
    title,
    subtitle,
    icon,
    iconTooltip,
    active,
    activating,
    onPrimaryClick = () => {},
    onSecondaryClick = () => {},
}: DeviceProps) {
    const titleB = accessor(title);
    const subtitleB = accessor(subtitle);
    const iconB = accessor(icon);
    const iconTooltipB = accessor(iconTooltip);
    const activeB = accessor(active);
    const activatingB = accessor(activating);

    const className = createComputed(
        [activeB, activatingB],
        (active, activating) =>
            `device ${active ? "active" : ""} ${activating ? "activating" : ""}`,
    );

    return (
        <box class={className} spacing={16}>
            <Gtk.GestureClick button={1} onPressed={onPrimaryClick} />
            <Gtk.GestureClick button={3} onPressed={onSecondaryClick} />

            <Icon
                visible={iconB.as((icon) => !!icon)}
                label={iconB.as((icon) => icon ?? "")}
                tooltipText={iconTooltipB.as((tooltip) => tooltip ?? "")}
            />
            <box
                orientation={Gtk.Orientation.VERTICAL}
                valign={Gtk.Align.CENTER}
            >
                <label
                    visible={titleB.as((title) => !!title)}
                    label={titleB.as((title) => title ?? "")}
                    halign={Gtk.Align.START}
                    hexpand
                    lines={1}
                    wrap={false}
                />
                <label
                    visible={subtitleB.as((subtitle) => !!subtitle)}
                    label={subtitleB.as((subtitle) => subtitle ?? "")}
                    class="secondary"
                    halign={Gtk.Align.START}
                    hexpand
                    lines={1}
                    wrap={false}
                />
            </box>
        </box>
    );
}
