import { register, signal } from "ags/gobject";
import { execAsync } from "ags/process";
import { interval } from "ags/time";
import GObject from "gi://GObject?version=2.0";

@register()
export default class Calendar extends GObject.Object {
    static instance: Calendar;
    static get_default(): Calendar {
        if (!this.instance) this.instance = new Calendar();
        return this.instance;
    }

    private _events: Map<string, Event> = new Map();

    constructor() {
        super();

        interval(15 * 60 * 1000, () =>
            execAsync([
                "khal",
                "list",
                "--format",
                '{{"uid":{uid!r},"title":{title!r},"description":{description!r},"location":{location!r},"start":{start!r},"end":{end!r}}}',
            ])
                .then((output) => {
                    const events = output
                        .replace(/vText\('b'(.*?)''\)/g, '"$1"')
                        .replace(/'(.*?)'/g, '"$1"')
                        .replace(/None/g, "null")
                        .replace(/True/g, "true")
                        .replace(/False/g, "false")
                        .split("\n");

                    for (const event of events) {
                        if (!event) continue;

                        const {
                            uid,
                            title,
                            description,
                            location,
                            start,
                            end,
                        }: {
                            uid: string;
                            title: string;
                            description: string;
                            location: string;
                            start: string;
                            end: string;
                        } = JSON.parse(event);
                        const allDay = !start.includes("T");

                        const existing = this._events.get(uid);

                        if (existing) {
                            // TODO
                        } else {
                            this._events.set(
                                uid,
                                new Event(
                                    uid,
                                    title,
                                    description,
                                    location,
                                    new Date(start),
                                    new Date(end),
                                    allDay,
                                ),
                            );
                            this.eventAdded(uid);
                        }
                    }
                })
                .catch((error) => console.error(error)),
        );
    }

    @signal([String], undefined, {
        default: false,
    })
    eventAdded(id: string) {}

    @signal([String], undefined, {
        default: false,
    })
    eventRemoved(id: string) {}
}

export class Event {
    constructor(
        public id: string,
        public title: string,
        public description: string,
        public location: string,
        public start: Date,
        public end: Date,
        public allDay: boolean,
    ) {}
}
