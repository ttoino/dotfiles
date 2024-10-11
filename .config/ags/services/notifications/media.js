import { SEPARATOR } from "../../chars.js";

const mpris = await Service.import("mpris");

/** @type {number} */
let mediaId;
mpris.connect("changed", async () => {
    const player = mpris.getPlayer();
    if (!player) return;

    const r = await Utils.execAsync([
        "notify-send",
        player.track_title,
        player.track_artists.join(SEPARATOR),
        "-a",
        player.name,
        "-i",
        player.cover_path,
        "-h",
        `string:class:player-${player.name}`,
        "-e",
        "-p",
        ...(mediaId !== undefined ? ["-r", mediaId.toString()] : []),
    ]);

    mediaId = parseInt(r.trim());
});

export {};
