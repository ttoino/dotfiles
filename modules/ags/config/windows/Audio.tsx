import Wp from "gi://AstalWp";
import {
    CHEVRON_DOWN,
    CHEVRON_UP,
    MICROPHONE,
    MICROPHONE_OFF,
    VOLUME_MUTE,
} from "../lib/chars";
import { volumeRange } from "../lib/icons";
import ExpandableWindow from "../widgets/ExpandableWindow";
import IconSlider from "../widgets/IconSlider";
import ScrollText from "../widgets/ScrollText";
import { Accessor, createBinding, createComputed, For } from "ags";
import { Astal, Gtk } from "ags/gtk4";
import app from "ags/gtk4/app";

const audio = Wp.get_default()?.audio;

const VolumeSlider = ({
    device,
    isSpeaker,
}: {
    device: Wp.Endpoint;
    isSpeaker: boolean;
}) => (
    <IconSlider
        hexpand
        drawValue={false}
        step={5}
        icon={
            isSpeaker
                ? createBinding(device, "volume").as(volumeRange)
                : MICROPHONE
        }
        value={createBinding(device, "volume")}
        onNotifyValue={({ value }) => (device.volume = value)}
    />
);

const MuteButton = ({
    device,
    isSpeaker,
}: {
    device: Wp.Endpoint;
    isSpeaker: boolean;
}) => (
    <togglebutton
        vexpand={false}
        valign={Gtk.Align.CENTER}
        class="icon"
        active={createBinding(device, "mute")}
        onToggled={({ active }) => device.set_mute(active)}
        label={createComputed(
            [createBinding(device, "mute"), createBinding(device, "volume")],
            (mute, volume) =>
                isSpeaker
                    ? mute
                        ? VOLUME_MUTE
                        : volumeRange(volume)
                    : mute
                      ? MICROPHONE_OFF
                      : MICROPHONE,
        )}
    />
);

const Device = ({
    devices,
    selectedDevice,
    setSelectedDevice,
    isSpeaker,
}: {
    devices: Accessor<Wp.Endpoint[]>;
    selectedDevice: Wp.Endpoint;
    setSelectedDevice: (device: Wp.Endpoint) => void;
    isSpeaker: boolean;
}) => {
    let stack: Gtk.Stack;

    const Title = ({
        title,
        icon,
        next,
    }: {
        title: string | Accessor<string>;
        icon: string;
        next: string;
    }) => (
        <box spacing={8}>
            <ScrollText label={title} />
            <button
                class="icon"
                onClicked={() => (stack.visibleChildName = next)}
            >
                {icon}
            </button>
        </box>
    );

    return (
        <stack
            class="audio-device"
            hexpand
            transitionType={Gtk.StackTransitionType.CROSSFADE}
            interpolateSize
            vhomogeneous={false}
            visibleChildName="volume"
            $={(s) => (stack = s)}
        >
            <box
                name="volume"
                orientation={Gtk.Orientation.VERTICAL}
                spacing={8}
                $type="named"
            >
                <Title
                    title={createBinding(selectedDevice, "description").as(
                        (description) =>
                            description ??
                            (isSpeaker ? "Speaker" : "Microphone"),
                    )}
                    icon={CHEVRON_DOWN}
                    next="select"
                />
                <box spacing={8}>
                    <VolumeSlider
                        device={selectedDevice}
                        isSpeaker={isSpeaker}
                    />
                    <MuteButton device={selectedDevice} isSpeaker={isSpeaker} />
                </box>
            </box>
            <box
                name="select"
                orientation={Gtk.Orientation.VERTICAL}
                spacing={8}
                $type="named"
            >
                <Title
                    title={`Default ${isSpeaker ? "Speaker" : "Microphone"}`}
                    icon={CHEVRON_UP}
                    next="volume"
                />
                <box orientation={Gtk.Orientation.VERTICAL} spacing={8}>
                    <For each={devices}>
                        {(device) => (
                            <button
                                class="device"
                                onClicked={() => {
                                    setSelectedDevice(device);
                                    stack.visibleChildName = "volume";
                                }}
                            >
                                <ScrollText
                                    label={createBinding(
                                        device,
                                        "description",
                                    ).as(
                                        (description) =>
                                            description ?? "Unknown",
                                    )}
                                />
                            </button>
                        )}
                    </For>
                </box>
            </box>
        </stack>
    );
};

const AudioContent = ({
    collapseButton,
    ...props
}: {
    collapseButton: JSX.Element;
    $type: "named";
    name: "expanded";
}) => {
    if (!audio) return <></>;

    return (
        <scrolledwindow
            vscrollbarPolicy={Gtk.PolicyType.AUTOMATIC}
            hscrollbarPolicy={Gtk.PolicyType.NEVER}
            {...props}
        >
            <box orientation={Gtk.Orientation.VERTICAL} spacing={16}>
                <box spacing={16}>
                    {collapseButton}
                    <label
                        hexpand
                        halign={Gtk.Align.START}
                        justify={Gtk.Justification.LEFT}
                        label="Audio"
                    />
                </box>
                <Device
                    devices={createBinding(audio, "speakers")}
                    selectedDevice={audio.defaultSpeaker}
                    setSelectedDevice={() => {}}
                    isSpeaker
                />
                <Device
                    devices={createBinding(audio, "microphones")}
                    selectedDevice={audio.defaultMicrophone}
                    setSelectedDevice={() => {}}
                    isSpeaker={false}
                />
            </box>
        </scrolledwindow>
    );
};

export default function Audio(props: Partial<JSX.IntrinsicElements["window"]>) {
    if (!audio) return <></>;

    return (
        <window
            name="audio"
            anchor={Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT}
            margin={16}
            application={app}
            {...props}
        >
            <ExpandableWindow
                collapsed={
                    <>
                        <VolumeSlider device={audio.defaultSpeaker} isSpeaker />
                        <MuteButton device={audio.defaultSpeaker} isSpeaker />
                    </>
                }
                expanded={AudioContent}
            />
        </window>
    );
}
