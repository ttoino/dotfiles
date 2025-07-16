import { Gtk } from "ags/gtk4";

export interface ScrollTextProps
    extends Omit<JSX.IntrinsicElements["scrolledwindow"], "children">,
        Pick<JSX.IntrinsicElements["label"], "label"> {
    labelProps?: Omit<JSX.IntrinsicElements["label"], "children">;
}

export default function ScrollText({
    class: className,
    label,
    labelProps,
    ...rest
}: ScrollTextProps) {
    return (
        <scrolledwindow
            class={`scroll-text ${className ?? ""}`}
            hexpand
            hscrollbarPolicy={Gtk.PolicyType.AUTOMATIC}
            vscrollbarPolicy={Gtk.PolicyType.NEVER}
            {...rest}
        >
            <label wrap={false} lines={1} label={label} {...labelProps} />
        </scrolledwindow>
    );
}
