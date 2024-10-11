/**
 * @typedef {Omit<
 *      import("types/widgets/scrollable").ScrollableProps, 
 *      "child" | "className" | "class_name" | "classNames" | "class_names"
 * > & {
 *      text: import("types/widgets/label.js").LabelProps['label'],
 *      textPack?: import("types/widgets/label.js").LabelProps['hpack'],
 *      classNames?: string[],
 * }} ScrollTextProps
 */

/**
 * @param {ScrollTextProps} props
 */
const ScrollText = ({ text, classNames = [], textPack = "start", ...rest }) => Widget.Scrollable({
    classNames: ["scroll-text", ...classNames],
    hexpand: true,
    hscroll: "automatic",
    vscroll: "never",
    child: Widget.Label({
        wrap: false,
        lines: 1,
        label: text,
        hpack: textPack,
    }),
    ...rest,
});

export default ScrollText;
