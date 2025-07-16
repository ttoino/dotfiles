import Mpris from "gi://AstalMpris";
import { MUSIC_NOTE, SEPARATOR } from "../lib/chars";
import IconButton from "../widgets/IconButton";
import { togglePopup } from "../services/windows";
import { createBinding } from "ags";

const media = Mpris.get_default();

export default function Media() {
    return (
        <IconButton
            class="media"
            visible={createBinding(media, "players").as((p) => p.length > 0)}
            tooltipText={createBinding(media, "players").as((players) =>
                players
                    .map(
                        (player) =>
                            `${player.title} ${SEPARATOR} ${
                                player.artist || player.albumArtist
                            }`,
                    )
                    .join("\n"),
            )}
            onClicked={() => togglePopup("media")}
        >
            {MUSIC_NOTE}
        </IconButton>
    );
}
