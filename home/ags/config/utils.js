/**
 * @param {string[]} icons
 * @param {number} value
 *
 * @returns {string}
 */
export const iconRange = (icons, value) => {
    const index = Math.min(
        Math.max(0, Math.floor(value * icons.length)),
        icons.length - 1
    );
    return icons[index];
};

const relativeTimeFormat = new Intl.RelativeTimeFormat("en", {
    numeric: "auto",
    style: "short",
});

/**
 *
 * @param {Date} date
 * @param {Date} to
 *
 * @returns {string}
 */
export const relativeTime = (date, to = new Date()) => {
    /**
     * @param {number} value
     * @param {Intl.RelativeTimeFormatUnit} unit
     * @returns {string}
     */
    const format = (value, unit) =>
        relativeTimeFormat.format(value, unit).split(/\./)[0];

    const secDiff = Math.floor((date.getTime() - to.getTime()) / 1000);

    if (Math.abs(secDiff) < 60) return format(secDiff, "second");

    const minDiff = Math.floor(secDiff / 60);

    if (Math.abs(minDiff) < 60) return format(minDiff, "minute");

    const hourDiff = Math.floor(minDiff / 60);

    if (Math.abs(hourDiff) < 24) return format(hourDiff, "hour");

    const dayDiff = Math.floor(hourDiff / 24);

    if (Math.abs(dayDiff) < 7) return format(dayDiff, "day");

    const weekDiff = Math.floor(dayDiff / 7);

    if (Math.abs(weekDiff) < 4) return format(weekDiff, "week");

    const monthDiff = Math.floor(dayDiff / 30);

    if (Math.abs(monthDiff) < 12) return format(monthDiff, "month");

    const yearDiff = Math.floor(dayDiff / 365);

    return format(yearDiff, "year");
};
