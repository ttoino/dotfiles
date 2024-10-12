import { VOLUME_HIGH } from "../chars.js";
import Cairo from "gi://cairo?version=1.0";
import GLib from "gi://GLib?version=2.0";
import GObject from "gi://GObject?version=2.0";
import Gtk from "gi://Gtk?version=3.0";
import Pango from "gi://Pango";
import { Slider } from "resource:///com/github/Aylur/ags/widgets/slider.js";

class IconSlider extends Slider {
    static {
        Widget.register(this, {
            properties: { icon: ["string", "rw"] },
            cssName: "icon-slider",
        });
    }

    /** @type {Pango.Layout} */
    #iconLayout;

    /**
     * @param {import("types/widgets/slider.js").SliderProps & import("types/service.js").BindableProps<{ icon: string }>} props
     */
    constructor(props) {
        super(props);

        this.#iconLayout = this.#createIconLayout();

        this.connect("screen-changed", () => {
            this.#iconLayout = this.#createIconLayout();
        });

        this.connect("notify::icon", () => {
            this.#iconLayout.set_text(this.icon ?? "", -1);
        });
    }

    /** @type {string} */
    get icon() {
        return this._get("icon");
    }
    set icon(value) {
        this._set("icon", value);
    }

    #createIconLayout() {
        const iconLayout = this.create_pango_layout(this.icon ?? "");
        iconLayout.set_alignment(Pango.Alignment.CENTER);

        return iconLayout;
    }

    /**
     * @override
     * @param {Cairo.Context} context
     * @returns {boolean}
     */
    vfunc_draw(context) {
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

/**
 * @param {ConstructorParameters<typeof IconSlider>[0]} props
 */
export default (props) => new IconSlider(props);
