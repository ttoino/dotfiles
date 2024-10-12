import {
    ALPHA_X_CIRCLE,
    FULLSCREEN,
    FULLSCREEN_EXIT,
    PIN,
    WINDOW_RESTORE,
} from "../chars.js";

const hyprland = await Service.import("hyprland");

const title = Variable(/** @type {string | undefined} */ (undefined));

const fullscreen = Variable(false);
const fullscreenType = Variable(0);
const floating = Variable(false);
const xwayland = Variable(false);
const pinned = Variable(false);

/**
 * @param {string} address
 */
const fromAddress = (address) => {
    const client = hyprland.getClient(address);

    title.value = client?.title ?? "";

    fullscreen.value = client?.fullscreen ?? false;
    fullscreenType.value = client?.fullscreenMode ?? 0;
    floating.value = client?.floating ?? false;
    xwayland.value = client?.xwayland ?? false;
    pinned.value = client?.pinned ?? false;
};

hyprland.active.client.connect("changed", ({ address }) =>
    fromAddress(address)
);

hyprland.connect(
    "event",
    (_, /** @type {string} */ name, /** @type {string} */ data) => {
        const dataArray = data.split(",");

        print(name, data);

        switch (name) {
            case "fullscreen":
                fromAddress(hyprland.active.client.address);
                break;
            case "changefloatingmode":
            case "windowtitle":
                if (`0x${dataArray[0]}` === hyprland.active.client.address)
                    fromAddress(hyprland.active.client.address);
                break;
        }
    }
);

const ActiveWindow = () =>
    Widget.Box({
        className: "active-window",
        spacing: 8,
        children: [
            Widget.Label({
                className: "icon",
                label: WINDOW_RESTORE,
                visible: floating.bind(),
            }),
            Widget.Label({
                className: "icon",
                label: fullscreenType
                    .bind()
                    .transform((t) => (t == 0 ? FULLSCREEN : FULLSCREEN_EXIT)),
                visible: fullscreen.bind(),
            }),
            Widget.Label({
                className: "icon",
                label: ALPHA_X_CIRCLE,
                visible: xwayland.bind(),
            }),
            Widget.Label({
                className: "icon",
                label: PIN,
                visible: pinned.bind(),
            }),
            Widget.Label({
                label: title.bind().transform((title) => title ?? ""),
                truncate: "end",
            }),
        ],
        visible: title.bind().transform((title) => title !== undefined),
    });

export default ActiveWindow;
