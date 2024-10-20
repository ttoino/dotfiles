import { bind, Binding, Variable } from "astal";
import { App, Astal, Gtk } from "astal/gtk3";
import { Stack } from "astal/gtk3/widget";
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
import ToggleButton from "../widgets/ToggleButton";

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
        icon={isSpeaker ? bind(device, "volume").as(volumeRange) : MICROPHONE}
        value={bind(device, "volume")}
        onDragged={({ value }) => (device.volume = value)}
    />
);

const MuteButton = ({
    device,
    isSpeaker,
}: {
    device: Wp.Endpoint;
    isSpeaker: boolean;
}) => (
    <ToggleButton
        vexpand={false}
        valign={Gtk.Align.CENTER}
        className="icon"
        active={bind(device, "mute")}
        onToggled={({ active }) => device.set_mute(active)}
    >
        {Variable.derive(
            [bind(device, "mute"), bind(device, "volume")],
            (mute, volume) =>
                isSpeaker
                    ? mute
                        ? VOLUME_MUTE
                        : volumeRange(volume)
                    : mute
                    ? MICROPHONE_OFF
                    : MICROPHONE
        )()}
    </ToggleButton>
);

const Device = ({
    devices,
    selectedDevice,
    setSelectedDevice,
    isSpeaker,
}: {
    devices: Binding<Wp.Endpoint[]>;
    selectedDevice: Wp.Endpoint;
    setSelectedDevice: (device: Wp.Endpoint) => void;
    isSpeaker: boolean;
}) => {
    let stack: Stack;

    const Title = ({
        title,
        icon,
        next,
    }: {
        title: string | Binding<string>;
        icon: string;
        next: string;
    }) => (
        <box spacing={8}>
            <ScrollText label={title} />
            <button
                className="icon"
                onClicked={() => (stack.visibleChildName = next)}
            >
                {icon}
            </button>
        </box>
    );

    return (
        <stack
            className="audio-device"
            hexpand
            transitionType={Gtk.StackTransitionType.CROSSFADE}
            interpolateSize
            vhomogeneous={false}
            visibleChildName="volume"
            setup={(s) => (stack = s)}
        >
            <box name="volume" spacing={8}>
                <Title
                    title={bind(selectedDevice, "description").as(
                        (description) =>
                            description ??
                            (isSpeaker ? "Speaker" : "Microphone")
                    )}
                    icon={CHEVRON_DOWN}
                    next="select"
                />
                <box vertical spacing={8}>
                    <VolumeSlider
                        device={selectedDevice}
                        isSpeaker={isSpeaker}
                    />
                    <MuteButton device={selectedDevice} isSpeaker={isSpeaker} />
                </box>
            </box>
            <box name="select" spacing={8}>
                <Title
                    title={`Default ${isSpeaker ? "Speaker" : "Microphone"}`}
                    icon={CHEVRON_UP}
                    next="volume"
                />
                <box vertical spacing={8}>
                    {devices.as((devices) =>
                        devices.map((device) => (
                            <button
                                child={
                                    <ScrollText
                                        label={bind(device, "description").as(
                                            (description) =>
                                                description ?? "Unknown"
                                        )}
                                    />
                                }
                                onClicked={() => {
                                    setSelectedDevice(device);
                                    stack.visibleChildName = "volume";
                                }}
                            />
                        ))
                    )}
                </box>
            </box>
        </stack>
    );
};

const AudioContent = (collapseButton: JSX.Element) => {
    if (!audio) return <></>;

    return (
        <scrollable
            vscroll={Gtk.PolicyType.AUTOMATIC}
            hscroll={Gtk.PolicyType.NEVER}
        >
            <box vertical spacing={16}>
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
                    devices={bind(audio, "speakers")}
                    selectedDevice={audio.defaultSpeaker}
                    setSelectedDevice={() => {}}
                    isSpeaker
                />
                <Device
                    devices={bind(audio, "microphones")}
                    selectedDevice={audio.defaultMicrophone}
                    setSelectedDevice={() => {}}
                    isSpeaker={false}
                />
            </box>
        </scrollable>
    );
};

export default function Audio() {
    if (!audio) return <></>;

    return (
        <window
            name="audio"
            anchor={Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT}
            margin={16}
            visible={false}
            application={App}
        >
            <ExpandableWindow
                collapsed={[
                    <VolumeSlider device={audio.defaultSpeaker} isSpeaker />,
                    <MuteButton device={audio.defaultSpeaker} isSpeaker />,
                ]}
                expanded={AudioContent}
            />
        </window>
    );
}

export const toggleAudio = () => App.toggle_window("audio");
