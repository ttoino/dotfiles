import Mpris from "gi://AstalMpris";
import { PAUSE, PLAY, SKIP_NEXT, SKIP_PREVIOUS } from "../lib/chars";
import IconButton from "../widgets/IconButton";
import ScrollText from "../widgets/ScrollText";
import { ascending } from "../lib/sorting";
import { Astal, Gtk } from "ags/gtk4";
import { createBinding, createComputed, createState, For } from "ags";
import app from "ags/gtk4/app";

const mpris = Mpris.get_default();

const Player = (player: Mpris.Player, onChoose: () => void) => (
    // Can't bind to busName because the widget name should not change
    <box
        name={player.busName}
        orientation={Gtk.Orientation.VERTICAL}
        spacing={8}
        $type="named"
    >
        <button onClicked={onChoose}>
            <ScrollText
                label={createComputed(
                    [
                        createBinding(player, "identity"),
                        createBinding(player, "busName"),
                    ],
                    (identity, busName) => identity ?? busName,
                )}
            />
        </button>
        <box
            class="cover"
            visible={createBinding(player, "coverArt").as((image) => !!image)}
            css={createBinding(player, "coverArt").as(
                (image) => `background-image: url("${image}")`,
            )}
        />
        <box orientation={Gtk.Orientation.VERTICAL}>
            <ScrollText class="title" label={createBinding(player, "title")} />
            <ScrollText
                class="artist"
                label={createBinding(player, "artist").as((a) => a ?? "")}
                visible={createBinding(player, "artist").as((a) => !!a)}
            />
        </box>
        <box spacing={16} halign={Gtk.Align.CENTER}>
            <IconButton
                class="lg"
                label={SKIP_PREVIOUS}
                valign={Gtk.Align.CENTER}
                onClicked={() => player.previous()}
            />
            <IconButton
                class="xl"
                label={createBinding(player, "playbackStatus").as((status) =>
                    status === Mpris.PlaybackStatus.PLAYING ? PAUSE : PLAY,
                )}
                onClicked={() => player.play_pause()}
            />
            <IconButton
                class="lg"
                label={SKIP_NEXT}
                valign={Gtk.Align.CENTER}
                onClicked={() => player.next()}
            />
        </box>
        <slider
            value={createBinding(player, "position")}
            max={createBinding(player, "length")}
            visible={createBinding(player, "length").as((v) => v > 0)}
            onNotifyValue={({ value }) => player.set_position(value)}
        />
    </box>
);

export default function Media(props: Partial<JSX.IntrinsicElements["window"]>) {
    const [visible, setVisible] = createState("_choose");

    const players = createBinding(mpris, "players").as((players) =>
        players.toSorted(
            (a, b) =>
                ascending(a.identity, b.identity) ||
                ascending(a.busName, b.busName),
        ),
    );

    return (
        <window
            name="media"
            anchor={Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT}
            margin={16}
            application={app}
            {...props}
        >
            <stack
                class="media-window info-window"
                transitionType={Gtk.StackTransitionType.CROSSFADE}
                visibleChildName={visible}
            >
                <box
                    name="_choose"
                    orientation={Gtk.Orientation.VERTICAL}
                    spacing={8}
                    $type="named"
                >
                    <label label="Choose a player" />
                    <For each={players}>
                        {(player) => (
                            <button
                                label={createBinding(player, "identity")}
                                onClicked={() => setVisible(player.busName)}
                            />
                        )}
                    </For>
                </box>

                <For each={players}>
                    {(player) => Player(player, () => setVisible("_choose"))}
                </For>
            </stack>
        </window>
    );
}
