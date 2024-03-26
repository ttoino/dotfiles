import ExpandableWindow from "../widgets/expandablewindow.js";
import {
    CHEVRON_DOWN,
    CHEVRON_UP,
    MICROPHONE,
    MICROPHONE_OFF,
    VOLUME_MUTE,
} from "../chars.js";
import { volumeRange } from "../icons.js";
import IconSlider from "../widgets/iconslider.js";
import ScrollText from "../widgets/scrolltext.js";

const audio = await Service.import("audio");

/**
 * @param {import("types/service/audio.js").Stream} device
 * @param {boolean} isSpeaker
 */
const VolumeSlider = (device, isSpeaker) =>
    IconSlider({
        hexpand: true,
        drawValue: false,
        step: 5,
        icon: isSpeaker
            ? device.bind("volume").transform((volume) => volumeRange(volume))
            : MICROPHONE,
        value: device.bind("volume"),
        onChange: ({ value }) => (device.volume = value),
    });

/**
 * @param {import("types/service/audio.js").Stream} device
 * @param {boolean} isSpeaker
 */
const MuteButton = (device, isSpeaker) =>
    Widget.ToggleButton({
        vexpand: false,
        vpack: "center",
        className: "icon",
        onToggled: ({ active }) => device.stream?.change_is_muted(active),
    }).hook(device, (self) => {
        self.label = isSpeaker
            ? device.stream?.isMuted
                ? VOLUME_MUTE
                : volumeRange(device.volume)
            : device.stream?.isMuted
            ? MICROPHONE_OFF
            : MICROPHONE;

        self.active = !!device.stream?.isMuted;
    });

/**
 * @param {import("types/service.js").Binding<any, any, import("types/service/audio.js").Stream[]>} devices
 * @param {import("types/service/audio.js").Stream} selectedDevice
 * @param {(device: import("types/service/audio.js").Stream) => void} setSelectedDevice
 * @param {boolean} isSpeaker
 */
const Device = (devices, selectedDevice, setSelectedDevice, isSpeaker) => {
    /**
     * @param {string | import("types/service.js").Binding<any, any, string>} title
     * @param {string} icon
     * @param {string} next
     */
    const Title = (title, icon, next) =>
        Widget.Box({
            spacing: 8,
            children: [
                ScrollText({
                    // hexpand: true,
                    // hpack: "start",
                    // justification: "left",
                    // maxWidthChars: 32,
                    // lines: 1,
                    // wrap: false,
                    // label: title,
                    text: title,
                }),
                Widget.Button({
                    className: "icon",
                    label: icon,
                    onClicked: () => {
                        stack.visible_child_name = next;
                    },
                }),
            ],
        });

    const stack = Widget.Stack({
        classNames: ["audio-device"],
        hexpand: true,
        visibleChildName: "volume",
        transition: "crossfade",
        interpolateSize: true,
        vhomogeneous: false,
        children: {
            volume: Widget.Box({
                spacing: 8,
                vertical: true,
                children: [
                    Title(
                        selectedDevice
                            .bind("description")
                            .transform(
                                (description) =>
                                    description ??
                                    (isSpeaker ? "Speaker" : "Microphone")
                            ),
                        CHEVRON_DOWN,
                        "select"
                    ),
                    Widget.Box({
                        vexpand: false,
                        spacing: 8,
                        children: [
                            VolumeSlider(selectedDevice, isSpeaker),
                            MuteButton(selectedDevice, isSpeaker),
                        ],
                    }),
                ],
            }),
            select: Widget.Box({
                spacing: 8,
                vertical: true,
                children: [
                    Title(
                        `Default ${isSpeaker ? "Speaker" : "Microphone"}`,
                        CHEVRON_UP,
                        "volume"
                    ),
                    Widget.Box({
                        vertical: true,
                        spacing: 8,
                        children: devices.transform((devices) =>
                            devices.map((device) =>
                                Widget.Button({
                                    child: ScrollText({
                                        text: device
                                            .bind("description")
                                            .transform(
                                                (description) =>
                                                    description ?? "Unknown"
                                            ),
                                    }),
                                    onClicked: () => {
                                        setSelectedDevice(device);
                                        stack.visible_child_name = "volume";
                                    },
                                })
                            )
                        ),
                    }),
                ],
            }),
        },
    });

    return stack;
};

const AudioContent = (collapseButton) =>
    Widget.Scrollable({
        vscroll: "automatic",
        hscroll: "never",
        child: Widget.Box({
            vertical: true,
            spacing: 16,
            children: [
                Widget.Box({
                    spacing: 16,
                    children: [
                        collapseButton,
                        Widget.Label({
                            hexpand: true,
                            hpack: "start",
                            justification: "left",
                            label: "Audio",
                        }),
                    ],
                }),
                Device(
                    audio.bind("speakers"),
                    audio.speaker,
                    (speaker) => (audio.speaker = speaker),
                    true
                ),
                Device(
                    audio.bind("microphones"),
                    audio.microphone,
                    (microphone) => (audio.microphone = microphone),
                    false
                ),
            ],
        }),
    });

const Audio = () =>
    Widget.Window({
        name: `audio`,
        anchor: ["bottom", "right"],
        margins: [16],
        visible: false,
        child: ExpandableWindow({
            collapsed: [
                VolumeSlider(audio.speaker, true),
                MuteButton(audio.speaker, true),
            ],
            expanded: AudioContent,
        }),
    });

export const toggleAudio = () => App.toggleWindow("audio");

export default Audio;
