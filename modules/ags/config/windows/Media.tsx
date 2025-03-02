import { bind, Variable } from "astal";
import { App, Astal, Gtk } from "astal/gtk3";
import Mpris from "gi://AstalMpris";
import { PAUSE, PLAY, SKIP_NEXT, SKIP_PREVIOUS } from "../lib/chars";
import IconButton from "../widgets/IconButton";
import ScrollText from "../widgets/ScrollText";
import Renderer from "../lib/Renderer";
import { ascending } from "../lib/sorting";

const mpris = Mpris.get_default();

const Player = (player: Mpris.Player, onChoose: () => void) => (
    // Can't bind to busName because the widget name should not change
    <box name={player.busName} vertical spacing={8}>
        <button onClicked={onChoose}>
            <ScrollText label={bind(player, "identity")} />
        </button>
        <box
            className="cover"
            visible={bind(player, "coverArt").as((image) => !!image)}
            css={bind(player, "coverArt").as(
                (image) => `background-image: url("${image}")`,
            )}
        />
        <box vertical>
            <ScrollText className="title" label={bind(player, "title")} />
            <ScrollText className="artist" label={bind(player, "artist")} />
        </box>
        <box spacing={16} halign={Gtk.Align.CENTER}>
            <IconButton
                className="lg"
                label={SKIP_PREVIOUS}
                valign={Gtk.Align.CENTER}
                onClicked={() => player.previous()}
            />
            <IconButton
                className="xl"
                label={bind(player, "playbackStatus").as((status) =>
                    status === Mpris.PlaybackStatus.PLAYING ? PAUSE : PLAY,
                )}
                onClicked={() => player.play_pause()}
            />
            <IconButton
                className="lg"
                label={SKIP_NEXT}
                valign={Gtk.Align.CENTER}
                onClicked={() => player.next()}
            />
        </box>
        <slider
            value={bind(player, "position")}
            max={bind(player, "length")}
            visible={bind(player, "position").as((v) => v > 0)}
            onDragged={({ value }) => player.set_position(value)}
        />
    </box>
);

export default function Media() {
    const visible = new Variable("choose");

    const choiceRenderer = new Renderer<Mpris.Player>(
        (player) => (
            <button
                label={bind(player, "identity")}
                onClicked={() => visible.set(player.busName)}
            />
        ),
        {
            initial: mpris.players,
            sort: (a, b) => ascending(a.identity, b.identity),
        },
    );
    const playerRenderer = new Renderer<Mpris.Player>(
        (player) => Player(player, () => visible.set("choose")),
        {
            initial: mpris.players,
            sort: (a, b) => ascending(a.identity, b.identity),
        },
    );

    mpris.connect("player-added", (_, player) => {
        choiceRenderer.add(player);
        playerRenderer.add(player);
    });
    mpris.connect("player-closed", (_, player) => {
        choiceRenderer.delete(player);
        playerRenderer.delete(player);
    });

    return (
        <window
            name="media"
            anchor={Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT}
            margin={16}
            visible={false}
            application={App}
        >
            <stack
                className="media-window info-window"
                transitionType={Gtk.StackTransitionType.CROSSFADE}
                visibleChildName={visible()}
                noImplicitDestroy
            >
                <box name="choose" vertical spacing={8} noImplicitDestroy>
                    <label label="Choose a player" />
                    {bind(choiceRenderer)}
                </box>
                {bind(playerRenderer)}
            </stack>
        </window>
    );
}
