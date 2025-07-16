import Hyprland from "gi://AstalHyprland";
import {
    ALPHA_X_CIRCLE,
    FULLSCREEN,
    FULLSCREEN_EXIT,
    PIN,
    WINDOW_RESTORE,
} from "../lib/chars";
import Icon from "../widgets/Icon";
import { createBinding, With } from "ags";
import Pango from "gi://Pango?version=1.0";

const hyprland = Hyprland.get_default();

export default function ActiveWindow() {
    const client = createBinding(hyprland, "focusedClient");

    return (
        <box class="active-window" spacing={8}>
            <With value={client}>
                {(client) => (
                    <label
                        ellipsize={Pango.EllipsizeMode.END}
                        visible={!!client}
                        label={client && createBinding(client, "title")}
                    />
                )}
            </With>

            <With value={client}>
                {(client) => (
                    <Icon
                        visible={client && createBinding(client, "floating")}
                        label={WINDOW_RESTORE}
                    />
                )}
            </With>

            <With value={client}>
                {(client) => (
                    <Icon
                        visible={
                            client &&
                            createBinding(client, "fullscreen").as(
                                (it) => !!(it & Hyprland.Fullscreen.MAXIMIZED),
                            )
                        }
                        label={FULLSCREEN_EXIT}
                    />
                )}
            </With>

            <With value={client}>
                {(client) => (
                    <Icon
                        visible={
                            client &&
                            createBinding(client, "fullscreen").as(
                                (it) => !!(it & Hyprland.Fullscreen.FULLSCREEN),
                            )
                        }
                        label={FULLSCREEN}
                    />
                )}
            </With>

            <With value={client}>
                {(client) => (
                    <Icon
                        visible={client && createBinding(client, "xwayland")}
                        label={ALPHA_X_CIRCLE}
                    />
                )}
            </With>

            <With value={client}>
                {(client) => (
                    <Icon
                        visible={client && createBinding(client, "pinned")}
                        label={PIN}
                    />
                )}
            </With>

            {/* <With value={createBinding(hyprland, "focusedClient")}>
                {(client) => {
                    if (!client) return <></>;

                    return (
                        <>
                            <label
                                ellipsize={Pango.EllipsizeMode.END}
                                label={createBinding(client, "title")}
                            />
                            <Icon
                                visible={createBinding(client, "floating")}
                                label={WINDOW_RESTORE}
                            />
                            <Icon
                                visible={createBinding(client, "fullscreen").as(
                                    (it) =>
                                        !!(it & Hyprland.Fullscreen.MAXIMIZED),
                                )}
                                label={FULLSCREEN_EXIT}
                            />
                            <Icon
                                visible={createBinding(client, "fullscreen").as(
                                    (it) =>
                                        !!(it & Hyprland.Fullscreen.FULLSCREEN),
                                )}
                                label={FULLSCREEN}
                            />
                            <Icon
                                visible={createBinding(client, "xwayland")}
                                label={ALPHA_X_CIRCLE}
                            />
                            <Icon
                                visible={createBinding(client, "pinned")}
                                label={PIN}
                            />
                        </>
                    );
                }}
            </With> */}
        </box>
    );
}
