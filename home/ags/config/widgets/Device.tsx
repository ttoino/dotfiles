import { Binding, Variable } from "astal";
import { Gtk, Astal } from "astal/gtk3/index";
import Icon from "./Icon";
import { binding } from "../lib/vars";

export interface DeviceProps {
    title?: string | Binding<string | undefined>;
    subtitle?: string | Binding<string | undefined>;
    icon?: string | Binding<string | undefined>;
    iconTooltip?: string | Binding<string | undefined>;
    active?: boolean | Binding<boolean | undefined>;
    activating?: boolean | Binding<boolean | undefined>;

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
    const titleB = binding(title);
    const subtitleB = binding(subtitle);
    const iconB = binding(icon);
    const iconTooltipB = binding(iconTooltip);
    const activeB = binding(active);
    const activatingB = binding(activating);

    const className = Variable.derive(
        [activeB, activatingB],
        (active, activating) =>
            `device ${active ? "active" : ""} ${activating ? "activating" : ""}`
    );

    return (
        <eventbox
            cursor="pointer"
            onClick={(self, event) =>
                event.button === Astal.MouseButton.PRIMARY
                    ? onPrimaryClick()
                    : event.button === Astal.MouseButton.SECONDARY
                    ? onSecondaryClick()
                    : undefined
            }
        >
            <box className={className()} spacing={16}>
                {iconB.as((icon) => (
                    <Icon
                        visible={!!icon}
                        label={icon ?? ""}
                        // tooltipText={iconTooltipB}
                    />
                ))}
                <box vertical valign={Gtk.Align.CENTER}>
                    {titleB.as((title) => (
                        <label
                            visible={!!title}
                            label={title ?? ""}
                            halign={Gtk.Align.START}
                            hexpand
                            lines={1}
                            wrap={false}
                        />
                    ))}
                    {subtitleB.as((subtitle) => (
                        <label
                            visible={!!subtitle}
                            label={subtitle ?? ""}
                            className="secondary"
                            halign={Gtk.Align.START}
                            hexpand
                            lines={1}
                            wrap={false}
                        />
                    ))}
                </box>
            </box>
        </eventbox>
    );
}
