import { Gtk } from "astal/gtk3";
import { LabelProps, ScrollableProps } from "astal/gtk3/widget";

export interface ScrollTextProps
    extends Omit<ScrollableProps, "children">,
        Pick<LabelProps, "label"> {
    labelProps?: Omit<LabelProps, "children">;
}

export default function ScrollText({
    className,
    label,
    labelProps,
    ...rest
}: ScrollTextProps) {
    return (
        <scrollable
            className={`scroll-text ${className}`}
            hexpand
            hscroll={Gtk.PolicyType.AUTOMATIC}
            vscroll={Gtk.PolicyType.NEVER}
            {...rest}
        >
            <label wrap={false} lines={1} label={label} {...labelProps} />
        </scrollable>
    );
}
