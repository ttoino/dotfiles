import { bgfg, prominentColors } from "../services/color.js";
import { PAUSE, PLAY, SEPARATOR, SKIP_NEXT, SKIP_PREVIOUS } from "../chars.js";
import ScrollText from "../widgets/scrolltext.js";

const mpris = await Service.import("mpris");

/**
 * @param {import("types/service/mpris.js").MprisPlayer} player
 */
const Player = (player) =>
    Widget.Box({
        name: player.bind("name").transform((name) => `player-${name}`),
        vertical: true,
        spacing: 8,
        children: [
            ScrollText({
                text: mpris.getPlayer()?.bind("name"),
            }),
            Widget.Box({
                className: "cover",
                visible: player
                    .bind("cover_path")
                    .transform((image) => !!image),
                css: player
                    .bind("cover_path")
                    .transform((image) => `background-image: url("${image}")`),
            }),
            Widget.Box({
                vertical: true,
                children: [
                    ScrollText({
                        classNames: ["title"],
                        textPack: "center",
                        text: player.bind("track_title"),
                    }),
                    ScrollText({
                        classNames: ["artist"],
                        textPack: "center",
                        text: player
                            .bind("track_artists")
                            .transform((artists) => artists.join(SEPARATOR)),
                    }),
                ],
            }),
            Widget.Box({
                spacing: 16,
                hpack: "center",
                children: [
                    Widget.Button({
                        classNames: ["icon", "lg"],
                        vpack: "center",
                        label: SKIP_PREVIOUS,
                        onClicked: () => player.previous(),
                    }),
                    Widget.Button({
                        classNames: ["icon", "xl"],
                        vpack: "center",
                        label: player
                            .bind("play_back_status")
                            .transform((status) =>
                                status === "Playing" ? PAUSE : PLAY
                            ),
                        onClicked: () => player.playPause(),
                    }),
                    Widget.Button({
                        classNames: ["icon", "lg"],
                        vpack: "center",
                        label: SKIP_NEXT,
                        onClicked: () => player.next(),
                    }),
                ],
            }),
            Widget.Slider({
                value: player.bind("position"),
                max: player.bind("length"),
                drawValue: false,
                visible: player.bind("position").transform((v) => v > 0),
            }),
        ],
    }).hook(
        player,
        () => {
            if (!player.cover_path) return "";

            const colors = bgfg(player.cover_path);

            if (!colors) return "";

            const cmd = `
bash -c 'sass -I ${App.configDir}/style - <<SASS
@use "components/colored.scss" as c;
#player-${player.name} { 
    @include c.colored-components(${colors[1]}, ${colors[0]});
    background-color: ${colors[0]};
    color: ${colors[1]};
}
SASS'`.trimStart();

            const css = Utils.exec(cmd);

            App.applyCss(css);
        },
        "notify::cover-path"
    );

const Media = () =>
    Widget.Window({
        name: "media",
        anchor: ["bottom", "right"],
        margins: [16],
        visible: false,
        child: Widget.Box({
            vertical: true,
            classNames: ["media-window", "info-window"],
            children: mpris
                .bind("players")
                .transform((players) => players.map(Player)),
        }),
    });

export const toggleMedia = () => App.toggleWindow("media");

export default Media;
