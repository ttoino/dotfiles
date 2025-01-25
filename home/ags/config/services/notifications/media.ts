import Mpris from "gi://AstalMpris";
import { notify } from "../../lib/notifications";

const mpris = Mpris.get_default();

let mediaId: string | undefined;

const onPlayerAdded = (player: Mpris.Player) => {
    const callback = async () => {
        const out = await notify({
            title: player.title,
            body: player.artist,
            appName: player.identity,
            image: player.coverArt,
            className: `player-${player.busName}`,
            id: mediaId,
            transient: true,
        });

        if (!mediaId) mediaId = out.trim();
    };

    player.connect("notify::title", callback);
    player.connect("notify::artist", callback);
    player.connect("notify::cover-art", callback);
    player.connect("notify::playback-status", callback);
};

mpris.players.forEach(onPlayerAdded);
mpris.connect("player-added", (_, player) => onPlayerAdded(player));

export {};
