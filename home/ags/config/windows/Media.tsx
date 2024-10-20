import { bind } from "astal";
import { App, Astal, Gtk } from "astal/gtk3";
import Mpris from "gi://AstalMpris";
import { PAUSE, PLAY, SKIP_NEXT, SKIP_PREVIOUS } from "../lib/chars";
import IconButton from "../widgets/IconButton";
import ScrollText from "../widgets/ScrollText";

const mpris = Mpris.get_default();

const Player = (player: Mpris.Player) => {
    print(player.length);
    print(player.position);
    print(player.coverArt);
    print(player.artUrl);

    return (
        <box name={bind(player, "busName")} vertical spacing={8}>
            <ScrollText label={bind(player, "busName")} />
            <box
                className="cover"
                visible={bind(player, "coverArt").as((image) => !!image)}
                css={bind(player, "coverArt").as(
                    (image) => `background-image: url("${image}")`
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
                    onClicked={() => player.previous()}
                />
                <IconButton
                    className="xl"
                    label={bind(player, "playbackStatus").as((status) =>
                        status === Mpris.PlaybackStatus.PLAYING ? PAUSE : PLAY
                    )}
                    onClicked={() => player.play_pause()}
                />
                <IconButton
                    className="lg"
                    label={SKIP_NEXT}
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
};

export default function Media() {
    return (
        <window
            name="media"
            anchor={Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT}
            margin={16}
            visible={false}
            application={App}
        >
            <box className="media-window info-window" vertical>
                {bind(mpris, "players").as((players) => players.map(Player))}
            </box>
        </window>
    );
}

export const toggleMedia = () => App.toggle_window("media");
