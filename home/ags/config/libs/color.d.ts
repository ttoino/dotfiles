// https://github.com/luukdv/color.js/

declare type Args = {
    amount: number;
    format: string;
    group: number;
    sample: number;
};
declare type Hex = string;
declare type Item = Url | HTMLImageElement;
declare type Output = Hex | Rgb | (Hex | Rgb)[];
declare type Rgb = [r: number, g: number, b: number];
declare type Url = string;
declare const average: (
    item: Item,
    args?: Partial<Args> | undefined
) => Promise<Output>;
declare const prominent: (
    item: Item,
    args?: Partial<Args> | undefined
) => Promise<Output>;
export { average, prominent };
