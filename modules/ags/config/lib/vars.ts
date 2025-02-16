import { Binding, Variable } from "astal";

export const binding = <T>(v: T | Binding<T>): Binding<T> =>
    v instanceof Binding ? v : Variable(v)();
