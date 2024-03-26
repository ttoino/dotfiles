import { MUSIC_NOTE } from "../chars.js";

const mpris = await Service.import("mpris");

const Media = () =>
    Widget.Button({
        classNames: ["media", "icon"],
        label: MUSIC_NOTE,
    }).hook(mpris, (self) => {
        self.visible = mpris.players.length > 0;

        print(JSON.stringify(mpris));
    });

export default Media;
