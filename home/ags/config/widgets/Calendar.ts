import { register } from "astal/gobject";
import { astalify, ConstructProps, Gtk } from "astal/gtk3";

export type CalendarProps = ConstructProps<
    Calendar,
    Gtk.Calendar.ConstructorProps,
    {}
>;

@register()
export default class Calendar extends astalify(Gtk.Calendar) {
    constructor(props: CalendarProps) {
        super(props as any);
    }
}
