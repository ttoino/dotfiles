import { volumeRange } from "../../icons.js";
import { sendSliderNotification } from "./slider.js";

const audio = await Service.import("audio");

let speakerId = undefined;
audio.speaker.connect("notify::volume", async (speaker) => {
    if (App.getWindow("audio")?.visible) return;

    const out = await sendSliderNotification(
        speaker.volume * 100,
        volumeRange(speaker.volume),
        "Volume",
        "audio",
        speakerId
    );

    if (!speakerId) speakerId = out.trim();
});

export {};
