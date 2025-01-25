import { Subscribable } from "astal/binding";
import { Gtk } from "astal/gtk3";

type Callback = (widgets: Gtk.Widget[]) => void;

export default class WidgetMap<K> implements Subscribable<Gtk.Widget[]> {
    #map: Map<K, Gtk.Widget>;
    #callbacks: Set<Callback> = new Set();

    constructor(entries?: readonly (readonly [K, Gtk.Widget])[]) {
        this.#map = new Map(entries);
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
        return [...this.#map.values()];
    }

    subscribe(callback: Callback) {
        this.#callbacks.add(callback);
        return () => this.#callbacks.delete(callback);
    }
}
