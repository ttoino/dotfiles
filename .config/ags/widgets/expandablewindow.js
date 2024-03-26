import { CHEVRON_LEFT, CHEVRON_RIGHT } from "../chars.js";
import Gtk from "gi://Gtk?version=3.0";

/**
 * @template {Gtk.Widget} [Collapsed=Gtk.Widget]
 * @template {Gtk.Widget} [Expanded=Gtk.Widget]
 * @typedef {{
 *     collapsed: Collapsed[];
 *     expanded: (collapse: import("types/widgets/button.js").Button) => Expanded;
 * }} Props
 */

/**
 * @param {Props} props
 */
const ExpandableWindow = ({ collapsed, expanded }) => {
    /** @type {import("types/widgets/stack.js").Stack} */
    const stack = Widget.Stack({
        classNames: ["expandable-window"],
        visibleChildName: "collapsed",
        transition: "slide_left_right",
        children: {
            collapsed: Widget.Box({
                spacing: 8,
                children: [
                    ...collapsed,
                    Widget.Button({
                        classNames: ["icon", "expand"],
                        label: CHEVRON_RIGHT,
                        onClicked: () => (stack.shown = "expanded"),
                    }),
                ],
            }),
            expanded: expanded(
                Widget.Button({
                    classNames: ["icon", "collapse"],
                    label: CHEVRON_LEFT,
                    onClicked: () => (stack.shown = "collapsed"),
                })
            ),
        },
    });

    stack.connect("notify::visible-child", () => {
        for (const child in stack.children)
            stack.toggleClassName(child, child === stack.visible_child_name);
    });

    return stack;
};

export default ExpandableWindow;
