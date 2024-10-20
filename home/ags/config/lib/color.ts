import GdkPixbuf from "gi://GdkPixbuf?version=2.0";

type Triplet = [number, number, number];

/**
 * r, g, b values are from 0 to 1 in linear space
 */
export const luminance = (r: number, g: number, b: number) =>
    r * 0.299 + g * 0.587 + b * 0.114;

/**
 * value is from 0 to 255 in sRGB space
 */
export const rgbToLinear = (value: number) => {
    const v = value / 255;
    return v <= 0.03928 ? v / 12.92 : Math.pow((v + 0.055) / 1.055, 2.4);
};

export const contrast = (rgb1: Triplet, rgb2: Triplet) => {
    const [r1, g1, b1] = rgb1.map(rgbToLinear);
    const [r2, g2, b2] = rgb2.map(rgbToLinear);

    const l1 = luminance(r1, g1, b1) + 0.05;
    const l2 = luminance(r2, g2, b2) + 0.05;

    return l1 > l2 ? l1 / l2 : l2 / l1;
};

/**
 * r, g, b values are from 0 to 255
 */
export const rgbToHex = (r: number, g: number, b: number) =>
    "#" + [r, g, b].map((v) => v.toString(16).padStart(2, "0")).join("");

const _group = (value: number, group: number) =>
    Math.min(Math.floor(value / group) * group, 255);

export const prominentColors = (
    image: string,
    { sample = 10, group = 16, amount = 3 } = {}
): Triplet[] => {
    const pixbuf = GdkPixbuf.Pixbuf.new_from_file(image);

    const data = pixbuf.get_pixels();

    const gap = pixbuf.get_n_channels() * sample;
    const colors = new Map<string, number>();

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
        .map(([rgb]) =>
            rgb.split(",").map((v) => parseInt(v, 10))
        ) as Triplet[];
};

export const bgfg = (image: string): [string, string] | undefined => {
    const colors: Triplet[] = [
        ...prominentColors(image, { amount: 4 }),
        [255, 255, 255],
        [0, 0, 0],
    ];
    const [bg, ...fgs] = colors;

    for (const fg of fgs)
        if (contrast(bg, fg) > 4.5) return [rgbToHex(...bg), rgbToHex(...fg)];
};
