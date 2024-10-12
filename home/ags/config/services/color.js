import GdkPixbuf from "gi://GdkPixbuf?version=2.0";

/**
 * r, g, b values are from 0 to 1 in linear space
 *
 * @param {number} r
 * @param {number} g
 * @param {number} b
 */
export const luminance = (r, g, b) => r * 0.299 + g * 0.587 + b * 0.114;

/**
 * value is from 0 to 255 in sRGB space
 *
 * @param {number} value
 */
export const rgbToLinear = (value) => {
    const v = value / 255;
    return v <= 0.03928 ? v / 12.92 : Math.pow((v + 0.055) / 1.055, 2.4);
};

/**
 * @param {[number, number, number]} rgb1
 * @param {[number, number, number]} rgb2
 */
export const contrast = (rgb1, rgb2) => {
    const [r1, g1, b1] = rgb1.map(rgbToLinear);
    const [r2, g2, b2] = rgb2.map(rgbToLinear);

    const l1 = luminance(r1, g1, b1) + 0.05;
    const l2 = luminance(r2, g2, b2) + 0.05;

    return l1 > l2 ? l1 / l2 : l2 / l1;
};

/**
 * r, g, b values are from 0 to 255
 *
 * @param {number} r
 * @param {number} g
 * @param {number} b
 */
export const rgbToHex = (r, g, b) =>
    "#" + [r, g, b].map((v) => v.toString(16).padStart(2, "0")).join("");

/**
 * @param {number} value
 * @param {number} group
 */
const _group = (value, group) =>
    Math.min(Math.floor(value / group) * group, 255);

/**
 * @param {string} image
 */
export const prominentColors = (
    image,
    { sample = 10, group = 16, amount = 3 } = {}
) => {
    const pixbuf = GdkPixbuf.Pixbuf.new_from_file(image);

    const data = pixbuf.get_pixels();

    const gap = pixbuf.get_n_channels() * sample;
    /** @type {Map<string, number>} */
    const colors = new Map();

    for (let i = 0; i < data.length; i += gap) {
        const rgb = [
            _group(data[i], group),
            _group(data[i + 1], group),
            _group(data[i + 2], group),
        ].join();

        colors.set(rgb, (colors.get(rgb) ?? 0) + 1);
    }

    return [...colors.entries()]
        .sort(([_keyA, valA], [_keyB, valB]) => (valA > valB ? -1 : 1))
        .slice(0, amount)
        .map(
            ([rgb]) =>
                /** @type {[number, number, number]} */ (
                    rgb.split(",").map((v) => parseInt(v, 10))
                )
        );
};

/**
 * @param {string} image
 *
 * @returns {[string, string] | undefined}
 */
export const bgfg = (image) => {
    /** @type {[number, number, number][]} */
    const colors = [
        ...prominentColors(image, { amount: 4 }),
        [255, 255, 255],
        [0, 0, 0],
    ];
    const [bg, ...fgs] = colors;

    for (const fg of fgs)
        if (contrast(bg, fg) > 4.5) return [rgbToHex(...bg), rgbToHex(...fg)];
};
