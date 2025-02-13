import { Subscribable } from "astal/binding";
import { Gtk } from "astal/gtk3";

type Callback = (widgets: Gtk.Widget[]) => void;
type OptionalArgs<T> = {
    initial?: readonly (readonly [T, Gtk.Widget])[];
    sort?: (a: T, b: T) => number;
};

export default class WidgetMap<K> implements Subscribable<Gtk.Widget[]> {
    #map: Map<K, Gtk.Widget>;
    #callbacks: Set<Callback> = new Set();
    #sort?: (a: K, b: K) => number;

    constructor({ initial, sort }: OptionalArgs<K> = {}) {
        this.#map = new Map(initial);
        this.#sort = sort;
    }

    #notify() {
        const widgets = this.get();
        for (const callback of this.#callbacks) callback(widgets);
    }

    #delete(key: K) {
        const v = this.#map.get(key);
        v?.destroy();
        this.#map.delete(key);
    }

    set(key: K, widget: Gtk.Widget) {
        this.#delete(key);
        this.#map.set(key, widget);
        this.#notify();
    }

    delete(key: K) {
        this.#delete(key);
        this.#notify();
    }

    get() {
        if (this.#sort) {
            return [...this.#map.entries()]
                .sort(([a], [b]) => this.#sort!(a, b))
                .map(([, value]) => value);
        }
        return [...this.#map.values()];
    }

    subscribe(callback: Callback) {
        this.#callbacks.add(callback);
        return () => this.#callbacks.delete(callback);
    }
}
