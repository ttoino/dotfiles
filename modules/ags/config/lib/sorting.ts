export const ascending = <T extends string | number | boolean | Date>(
    a: T,
    b: T,
) => {
    switch (typeof a) {
        case "string":
            return a.localeCompare(b as string);
        case "number":
            return a - (b as number);
        case "boolean":
            return (a ? 1 : 0) - (b ? 1 : 0);
        case "object":
            return a.getTime() - (b as Date).getTime();
    }
};

export const descending = <T extends string | number | boolean | Date>(
    a: T,
    b: T,
) => ascending(b, a);
