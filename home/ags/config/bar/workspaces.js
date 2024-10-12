import { RADIOBOX_BLANK, RADIOBOX_MARKED } from "../chars.js";

const hyprland = await Service.import("hyprland");

const WORKSPACE_COUNT = 10;

const workspaces = Array.from({ length: WORKSPACE_COUNT }, (_, i) =>
    Variable(hyprland.active.workspace.id === i + 1)
);

hyprland.active.workspace.connect("changed", ({ id }) => {
    workspaces.forEach((ws, i) => (ws.value = i + 1 === id));
});

const Workspaces = () =>
    Widget.Box({
        className: "workspaces",
        spacing: 4,
        children: workspaces.map((ws, id) =>
            Widget.Button({
                classNames: ["icon"],
                label: ws
                    .bind()
                    .transform((active) =>
                        active ? RADIOBOX_MARKED : RADIOBOX_BLANK
                    ),
                onClicked: () =>
                    hyprland.messageAsync(`dispatch workspace ${id + 1}`),
            })
        ),
    });

export default Workspaces;
