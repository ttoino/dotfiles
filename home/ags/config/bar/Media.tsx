import { bind } from "astal";
import Mpris from "gi://AstalMpris";
import { MUSIC_NOTE, SEPARATOR } from "../lib/chars";
import IconButton from "../widgets/IconButton";
import { toggleMedia } from "../windows/Media";

const media = Mpris.get_default();

export default function Media() {
    return (
        <IconButton
            className="media"
            visible={bind(media, "players").as((p) => p.length > 0)}
            tooltipText={bind(media, "players").as((players) =>
                players
                    .map(
                        (player) =>
                            `${player.title} ${SEPARATOR} ${
                                player.artist || player.albumArtist
                            }`
                    )
                    .join("\n")
            )}
            onClicked={toggleMedia}
        >
            {MUSIC_NOTE}
        </IconButton>
    );
}
