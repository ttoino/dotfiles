import { bind } from "astal";
import Hyprland from "gi://AstalHyprland";
import {
    ALPHA_X_CIRCLE,
    FULLSCREEN,
    FULLSCREEN_EXIT,
    PIN,
    WINDOW_RESTORE,
} from "../lib/chars";
import Icon from "../widgets/Icon";

const hyprland = Hyprland.get_default();

export default function ActiveWindow() {
    return (
        <box className="active-window" spacing={8}>
            <Icon
                visible={bind(hyprland.focusedClient, "floating")}
                label={WINDOW_RESTORE}
            />
            <Icon
                visible={bind(hyprland.focusedClient, "fullscreen").as(
                    (it) => it > Hyprland.Fullscreen.NONE
                )}
                label={bind(hyprland.focusedClient, "fullscreen").as((it) =>
                    it == Hyprland.Fullscreen.FULLSCREEN
                        ? FULLSCREEN
                        : FULLSCREEN_EXIT
                )}
            />
            <Icon
                visible={bind(hyprland.focusedClient, "xwayland")}
                label={ALPHA_X_CIRCLE}
            />
            <Icon visible={bind(hyprland.focusedClient, "pinned")}>{PIN}</Icon>
            <label truncate label={bind(hyprland.focusedClient, "title")} />
        </box>
    );
}
