import { property, register } from "astal/gobject";
import { Astal, ConstructProps, Gtk } from "astal/gtk3";
import { Slider, SliderProps } from "astal/gtk3/widget";
import Cairo from "gi://cairo";
import Pango from "gi://Pango";

export type IconSliderProps = ConstructProps<
    IconSlider,
    Astal.Slider.ConstructorProps & { icon: string },
    { onDragged: [] }
>;

@register({ CssName: "icon-slider" })
export default class IconSlider extends Slider {
    #iconLayout: Pango.Layout;

    constructor(props?: IconSliderProps) {
        super(props as SliderProps);

        this.#iconLayout = this.#createIconLayout();

        this.connect("screen-changed", () => {
            this.#iconLayout = this.#createIconLayout();
        });

        this.connect("notify::icon", () => {
            this.#iconLayout.set_text(this.icon ?? "", -1);
        });
    }

    @property(String)
    get icon() {
        return this.get_icon();
    }
    set icon(icon) {
        this.set_icon(icon);
    }
    get_icon() {
        return (this as any).__icon as string;
    }
    set_icon(icon: string) {
        if (this.get_icon() === icon) return;

        (this as any).__icon = icon;
    }

    #createIconLayout() {
        const iconLayout = this.create_pango_layout(this.icon ?? "");
        iconLayout.set_alignment(Pango.Alignment.CENTER);

        return iconLayout;
    }

    vfunc_draw(context: Cairo.Context) {
        super.vfunc_draw(context);

        const rect = this.get_range_rect();
        const [sliderStart, sliderEnd] = this.get_slider_range();

        this.#iconLayout.set_width(sliderEnd - sliderStart);

        const layoutHeight = this.#iconLayout.get_pixel_size()[1];

        Gtk.render_layout(
            this.get_style_context(),
            context,
            (sliderStart + sliderEnd) / 2,
            rect.y + (rect.height - layoutHeight) / 2,
            this.#iconLayout
        );

        return false;
    }
}
