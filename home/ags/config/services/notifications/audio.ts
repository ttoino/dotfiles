import { App } from "astal/gtk3";
import Wp from "gi://AstalWp";
import { volumeRange } from "../../lib/icons";
import { notify } from "../../lib/notifications";

const audio = Wp.get_default();

let speakerId: string | undefined;
audio?.defaultSpeaker.connect(
    "notify::volume",
    async (speaker: Wp.Endpoint) => {
        if (App.get_window("audio")?.visible) return;

        const out = await notify({
            title: "Volume",
            slider: {
                value: speaker.volume * 100,
                icon: volumeRange(speaker.volume),
            },
            className: "audio",
            id: speakerId,
            hideBody: true,
            hideHeader: true,
        });

        if (!speakerId) speakerId = out.trim();
    }
);

export {};
