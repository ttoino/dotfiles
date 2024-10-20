import { bind, Variable } from "astal";
import Hyprland from "gi://AstalHyprland";
import {
    RADIOBOX_BLANK,
    RADIOBOX_INDETERMINATE,
    RADIOBOX_MARKED,
} from "../lib/chars";
import IconButton from "../widgets/IconButton";

const hyprland = Hyprland.get_default();

const WORKSPACE_COUNT = 10;

const workspaces = Variable.derive(
    [bind(hyprland, "workspaces"), bind(hyprland, "focusedMonitor")],
    (wss, monitor) =>
        Array.from(
            { length: WORKSPACE_COUNT },
            (_, i) =>
                wss.find((ws) => ws.id === i + 1) ??
                Hyprland.Workspace.dummy(i + 1, monitor)
        )
);

export default function Workspaces() {
    return (
        <box className="workspaces" spacing={4}>
            {workspaces().as((wss) =>
                wss.map((ws) => (
                    <IconButton
                        onClicked={() =>
                            hyprland.dispatch("workspace", ws.id.toString())
                        }
                    >
                        {Variable.derive(
                            [
                                bind(hyprland, "focusedWorkspace"),
                                bind(ws, "clients"),
                            ],
                            (fw, clients) =>
                                fw.id === ws.id
                                    ? RADIOBOX_MARKED
                                    : clients.length > 0
                                    ? RADIOBOX_INDETERMINATE
                                    : RADIOBOX_BLANK
                        )()}
                    </IconButton>
                ))
            )}
        </box>
    );
}
