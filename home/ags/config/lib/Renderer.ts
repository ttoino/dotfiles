import { Subscribable } from "astal/binding";
import WidgetMap from "./WidgetMap";
import { Gtk } from "astal/gtk3";

type RendererFn<T> = (key: T) => Gtk.Widget | undefined;

export default class Renderer<T> implements Subscribable<Gtk.Widget[]> {
    #map: WidgetMap<T> = new WidgetMap();
    #renderer: RendererFn<T>;

    constructor(renderer: RendererFn<T>, empty?: Gtk.Widget) {
        this.#renderer = renderer;
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
