import { Accessor } from "ags";
import { Astal } from "ags/gtk4";
import app from "ags/gtk4/app";
import { accessor } from "../lib/vars";

export default function Scrim(
    props: Partial<Omit<JSX.IntrinsicElements["window"], "gdkmonitor">> &
        Required<Pick<JSX.IntrinsicElements["window"], "gdkmonitor">>,
) {
    return (
        <window
            name={accessor(props.gdkmonitor).as(
                (monitor) => `scrim-${monitor.model}`,
            )}
            namespace="ags-scrim"
            class="scrim-window"
            anchor={
                Astal.WindowAnchor.BOTTOM |
                Astal.WindowAnchor.LEFT |
                Astal.WindowAnchor.RIGHT |
                Astal.WindowAnchor.TOP
            }
            layer={Astal.Layer.OVERLAY}
            exclusivity={Astal.Exclusivity.IGNORE}
            application={app}
            {...props}
        />
    );
}
