import { GObject } from "astal";
import { astalify, ConstructProps, Gtk } from "astal/gtk3";

export type ToggleButtonProps = ConstructProps<
    ToggleButton,
    Gtk.ToggleButton.ConstructorProps,
    {}
>;

export default class ToggleButton extends astalify(Gtk.ToggleButton) {
    static {
        GObject.registerClass(this);
    }

    constructor(props?: ToggleButtonProps) {
        super(props as any);
    }
}
