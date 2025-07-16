import { getter, register, setter } from "ags/gobject";
import { Astal, Gdk, Gtk } from "ags/gtk4";
import GObject from "gi://GObject?version=2.0";

export interface IconSliderProps extends Astal.Slider.ConstructorProps {
    icon: string;
}

@register({ CssName: "icon-slider" })
export default class IconSlider extends Astal.Slider {
    #iconLabel: Gtk.Label;

    declare private __icon: string;

    constructor(props?: Partial<IconSliderProps>) {
        super(props);

        this.#iconLabel = new Gtk.Label({
            cssName: "icon-label",
            halign: Gtk.Align.CENTER,
            valign: Gtk.Align.CENTER,
        });
        this.#iconLabel.set_parent(this);
        this.bind_property("icon", this.#iconLabel, "label", GObject.BindingFlags.SYNC_CREATE);
    }

    vfunc_snapshot(snapshot: Gtk.Snapshot): void {
        super.vfunc_snapshot(snapshot);

        const [sliderStart, sliderEnd] = this.get_slider_range();

        const [, iconWidth] = this.#iconLabel.measure(Gtk.Orientation.HORIZONTAL, -1);
        const [, iconHeight] = this.#iconLabel.measure(Gtk.Orientation.VERTICAL, -1);

        const { height } = this.get_allocation();

        const allocation = new Gdk.Rectangle({
            x: Math.round((sliderStart + sliderEnd - iconWidth) / 2),
            y: Math.round((height - iconHeight) / 2),
            width: iconWidth,
            height: iconHeight,
        });

        this.#iconLabel.size_allocate(allocation, -1);

        this.snapshot_child(this.#iconLabel, snapshot);
    }

    @getter(String)
    get icon() {
        return this.get_icon();
    }
    @setter(String)
    set icon(icon) {
        this.set_icon(icon);
    }
    get_icon() {
        return this.__icon;
    }
    set_icon(icon: string) {
        if (this.get_icon() === icon) return;

        this.__icon = icon;
    }
}
