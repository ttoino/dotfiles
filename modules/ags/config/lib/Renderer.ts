import { Subscribable } from "astal/binding";
import WidgetMap from "./WidgetMap";
import { Gtk } from "astal/gtk3";

type RendererFn<T> = (key: T) => Gtk.Widget | undefined;
type OptionalArgs<T> = {
    initial?: T[];
    sort?: (a: T, b: T) => number;
};

export default class Renderer<T> implements Subscribable<Gtk.Widget[]> {
    #map: WidgetMap<T>;
    #renderer: RendererFn<T>;

    constructor(
        renderer: RendererFn<T>,
        { initial, sort }: OptionalArgs<T> = {}
    ) {
        this.#renderer = renderer;
        this.#map = new WidgetMap({
            initial: initial
                ?.map((key) => [key, renderer(key)])
                .filter(([key, widget]) => !!widget) as [T, Gtk.Widget][],
            sort,
        });
    }

    add(key: T) {
        const widget = this.#renderer(key);
        if (widget) this.#map.set(key, widget);
    }

    delete(key: T) {
        this.#map.delete(key);
    }

    get() {
        return this.#map.get();
    }

    subscribe(callback: (widgets: Gtk.Widget[]) => void) {
        return this.#map.subscribe(callback);
    }
}
