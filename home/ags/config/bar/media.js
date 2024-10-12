import { toggleMedia } from "../windows/media.js";
import { MUSIC_NOTE, SEPARATOR } from "../chars.js";

const mpris = await Service.import("mpris");

const Media = () =>
    Widget.Button({
        classNames: ["media", "icon"],
        label: MUSIC_NOTE,
        onClicked: () => toggleMedia(),
    }).hook(mpris, (self) => {
        self.visible = mpris.players.length > 0;

        self.tooltip_text = mpris.players
            .map(
                (player) =>
                    `${
                        player.track_title
                    } ${SEPARATOR} ${player.track_artists.join(
                        ` ${SEPARATOR} `
                    )}`
            )
            .join("\n");
    });

export default Media;
