import { Binding } from "astal";
import { Gtk } from "astal/gtk3/index";
import Icon from "./Icon";

export interface DeviceProps {
    title: string | Binding<string>;
    subtitle?: string | Binding<string>;
    icon: string | Binding<string>;
    iconTooltip?: string | Binding<string | undefined>;
    active?: boolean | Binding<boolean>;
    activating?: boolean | Binding<boolean>;
}

export default function Device({
    title,
    subtitle,
    icon,
    iconTooltip,
    active,
    activating,
}: DeviceProps) {
    return (
        <eventbox cursor="pointer">
            <box
                className="device"
                spacing={16}
                setup={(self) => {
                    if (active instanceof Binding)
                        active.subscribe((active) =>
                            self.toggleClassName("active", active)
                        );
                    else self.toggleClassName("active", active);

                    if (activating instanceof Binding)
                        activating.subscribe((activating) =>
                            self.toggleClassName("activating", activating)
                        );
                    else self.toggleClassName("activating", activating);
                }}
            >
                <Icon
                    label={icon}
                    // tooltipText={iconTooltip}
                />
                <box vertical valign={Gtk.Align.CENTER}>
                    <label
                        label={title}
                        halign={Gtk.Align.START}
                        hexpand
                        lines={1}
                        wrap={false}
                    />
                    {subtitle && (
                        <label
                            label={subtitle}
                            className="secondary"
                            halign={Gtk.Align.START}
                            hexpand
                            lines={1}
                            wrap={false}
                        />
                    )}
                </box>
            </box>
        </eventbox>
    );
}
