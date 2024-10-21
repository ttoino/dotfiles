import { bind } from "astal";
import { Gtk } from "astal/gtk3";
import { Stack, StackProps } from "astal/gtk3/widget";
import { CHEVRON_LEFT, CHEVRON_RIGHT } from "../lib/chars";
import IconButton from "./IconButton";

export interface ExpandableWindowProps extends Omit<StackProps, "children"> {
    collapsed: JSX.Element | JSX.Element[];
    expanded: (collapseButton: JSX.Element) => JSX.Element;
}

export default function ExpandableWindow({
    className,
    collapsed,
    expanded,
    ...rest
}: ExpandableWindowProps) {
    let stack: Stack;

    const expandedChild = expanded(
        <IconButton
            className="collapse"
            onClicked={() => (stack.visibleChildName = "collapsed")}
        >
            {CHEVRON_LEFT}
        </IconButton>
    );
    expandedChild.name = "expanded";

    return (
        <stack
            className={`expandable-window ${className}`}
            transitionType={Gtk.StackTransitionType.SLIDE_LEFT_RIGHT}
            visibleChildName="collapsed"
            setup={(s) => {
                stack = s;

                bind(stack, "visibleChildName").subscribe((visibleChild) => {
                    for (const child of stack.get_children())
                        stack.toggleClassName(
                            child.name,
                            child.name === visibleChild
                        );
                });
            }}
            {...rest}
        >
            <box name="collapsed" spacing={8}>
                {collapsed}
                <IconButton
                    className="expand"
                    onClicked={() => (stack.visibleChildName = "expanded")}
                >
                    {CHEVRON_RIGHT}
                </IconButton>
            </box>
            {expandedChild}
        </stack>
    );
}
