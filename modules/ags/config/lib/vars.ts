import { Accessor, createState } from "ags";

export const accessor = <T>(v: T | Accessor<T>): Accessor<T> =>
    v instanceof Accessor ? v : createState(v)[0];
