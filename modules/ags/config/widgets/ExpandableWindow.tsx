import { createState } from "ags";
import { CHEVRON_LEFT, CHEVRON_RIGHT } from "../lib/chars";
import IconButton from "./IconButton";
import Gtk from "gi://Gtk?version=4.0";

export interface ExpandableWindowProps
    extends Partial<Omit<JSX.IntrinsicElements["stack"], "children">> {
    collapsed: JSX.Element;
    expanded: (props: {
        collapseButton: JSX.Element;
        $type: "named";
        name: "expanded";
    }) => JSX.Element;
}

export default function ExpandableWindow({
    class: className = "",
    collapsed,
    expanded: Expanded,
    ...rest
}: ExpandableWindowProps) {
    const [visible, setVisible] = createState("collapsed");

    return (
        <stack
            class={visible.as(
                (visible) => `expandable-window ${visible} ${className}`,
            )}
            transitionType={Gtk.StackTransitionType.SLIDE_LEFT_RIGHT}
            visibleChildName={visible}
            {...rest}
        >
            <box name="collapsed" spacing={8} $type="named">
                {collapsed}
                <IconButton
                    class="expand"
                    onClicked={() => setVisible("expanded")}
                >
                    {CHEVRON_RIGHT}
                </IconButton>
            </box>

            <Expanded
                name="expanded"
                $type="named"
                collapseButton={
                    <IconButton
                        class="collapse"
                        onClicked={() => setVisible("collapsed")}
                    >
                        {CHEVRON_LEFT}
                    </IconButton>
                }
            />
        </stack>
    );
}
