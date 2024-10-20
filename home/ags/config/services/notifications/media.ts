import Mpris from "gi://AstalMpris";
import { notify } from "../../lib/notifications";

const mpris = Mpris.get_default();

let mediaId: string | undefined;
mpris.connect("player-added", (mpris, player) => {
    const callback = async () => {
        const out = await notify({
            title: player.title,
            body: player.artist,
            appName: player.busName,
            icon: player.coverArt,
            className: `player-${player.busName}`,
            id: mediaId,
        });

        if (!mediaId) mediaId = out.trim();
    };

    player.connect("notify::title", callback);
    player.connect("notify::artist", callback);
    player.connect("notify::cover-art", callback);
});

export {};
