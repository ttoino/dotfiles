import { monitorFile, readFile } from "ags/file";
import { getter, register, setter } from "ags/gobject";
import { exec } from "ags/process";
import GObject from "gi://GObject?version=2.0";

const get = (args: string) => exec(`brightnessctl -m ${args}`);

@register()
export default class Brightness extends GObject.Object {
    static instance: Brightness;
    static get_default(): Brightness {
        if (!this.instance) this.instance = new Brightness();
        return this.instance;
    }

    #value: number;
    #max: number;

    @getter(Number)
    get percentage() {
        return this.#value / this.#max;
    }

    @setter(Number)
    set percentage(percent) {
        if (percent < 0) percent = 0;
        if (percent > 1) percent = 1;
        this.#value = parseInt(get(`set ${percent * 100}%`).split(",")[2]);
        this.notify("percentage");
    }

    constructor() {
        super();

        const [device, class_, value, , max] = get("info").split(",");

        this.#value = parseInt(value);
        this.#max = parseInt(max);

        monitorFile(`/sys/class/${class_}/${device}/brightness`, (f) => {
            this.#value = parseInt(readFile(f));
            this.notify("percentage");
        });
    }
}
