import { Variable, bind } from "astal";
import Wp from "gi://AstalWp";
import { SEPARATOR, VOLUME_MUTE } from "../lib/chars";
import { volumeRange } from "../lib/icons";
import IconButton from "../widgets/IconButton";
import { toggleAudio } from "../windows/Audio";

const audio = Wp.get_default();

const icon =
    audio &&
    Variable.derive(
        [
            bind(audio.default_speaker, "mute"),
            bind(audio.defaultSpeaker, "volume"),
        ],
        (mute, volume) => (mute ? VOLUME_MUTE : volumeRange(volume))
    );
const tooltip =
    audio &&
    Variable.derive(
        [
            bind(audio.default_speaker, "description"),
            bind(audio.default_speaker, "mute"),
            bind(audio.defaultSpeaker, "volume"),
        ],
        (description, mute, volume) => {
            const parts = [description, Math.round(volume * 100) + "%"];

            if (mute) parts.push("Muted");

            return parts.join(` ${SEPARATOR} `);
        }
    );

export default function Audio() {
    if (!audio || !icon || !tooltip) return <></>;

    return (
        <IconButton
            className="audio"
            tooltipText={tooltip()}
            onClicked={toggleAudio}
        >
            {icon()}
        </IconButton>
    );
}
