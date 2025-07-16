import Hyprland from "gi://AstalHyprland";
import {
    RADIOBOX_BLANK,
    RADIOBOX_INDETERMINATE,
    RADIOBOX_MARKED,
} from "../lib/chars";
import IconButton from "../widgets/IconButton";
import { createBinding, createComputed, For } from "ags";

const hyprland = Hyprland.get_default();

const WORKSPACE_COUNT = 10;

const workspaces = createComputed(
    [
        createBinding(hyprland, "workspaces"),
        createBinding(hyprland, "focusedMonitor"),
    ],
    (wss, monitor) =>
        Array.from(
            { length: WORKSPACE_COUNT },
            (_, i) =>
                wss.find((ws) => ws.id === i + 1) ??
                Hyprland.Workspace.dummy(i + 1, monitor),
        ),
);

export default function Workspaces() {
    return (
        <box class="workspaces" spacing={4}>
            <For each={workspaces}>
                {(ws) => (
                    <IconButton
                        onClicked={() =>
                            hyprland.dispatch("workspace", ws.id.toString())
                        }
                        label={createComputed(
                            [
                                createBinding(hyprland, "focusedWorkspace"),
                                createBinding(ws, "clients"),
                            ],
                            (fw, clients) =>
                                fw.id === ws.id
                                    ? RADIOBOX_MARKED
                                    : clients.length > 0
                                      ? RADIOBOX_INDETERMINATE
                                      : RADIOBOX_BLANK,
                        )}
                    />
                )}
            </For>
        </box>
    );
}
