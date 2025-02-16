import { exec } from "astal";
import GObject, { register } from "astal/gobject";

@register()
export default class Power extends GObject.Object {
    static instance: Power;
    static get_default(): Power {
        if (!this.instance) this.instance = new Power();
        return this.instance;
    }

    shutdown() {
        exec("shutdown now");
    }

    restart() {
        exec("reboot");
    }

    sleep() {
        exec("systemctl suspend");
    }

    hibernate() {
        exec("systemctl hibernate");
    }

    lock() {
        exec("loginctl lock-session");
    }
}
