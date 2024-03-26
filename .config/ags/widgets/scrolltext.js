/**
 * @typedef {{
 *      text: import("types/widgets/label.js").LabelProps['label'],
 * }} ScrollTextProps
 */

/**
 * @param {ScrollTextProps} props
 */
const ScrollText = ({ text }) => Widget.Scrollable({
    className: "scroll-text",
    hexpand: true,
    hscroll: "automatic",
    vscroll: "never",
    child: Widget.Label({
        hpack: "start",
        wrap: false,
        lines: 1,
        label: text,
    }),
});

export default ScrollText;
