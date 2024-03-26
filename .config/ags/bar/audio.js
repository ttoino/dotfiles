import { toggleAudio } from "../windows/audio.js";
import { SEPARATOR, VOLUME_MUTE } from "../chars.js";
import { volumeRange } from "../icons.js";

const audio = await Service.import("audio");

const Audio = () =>
    Widget.Button({
        classNames: ["icon", "audio"],
        onClicked: () => {
            toggleAudio();
        },
    }).hook(audio.speaker, (self, speaker) => {
        self.label = audio.speaker.stream?.isMuted
            ? VOLUME_MUTE
            : volumeRange(audio.speaker.volume);

        const tooltipParts = [
            audio.speaker.description,
            Math.round(audio.speaker.volume * 100) + "%",
        ];

        if (audio.speaker.stream?.isMuted) tooltipParts.push("Muted");

        self.tooltip_text = tooltipParts.join(` ${SEPARATOR} `);
    });

export default Audio;
