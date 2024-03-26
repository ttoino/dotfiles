/**
 *
 * @param {number} value
 * @param {string} icon
 * @param {string} title
 * @param {string} classname
 * @param {string | number | undefined} id
 * @returns
 */
export const sendSliderNotification = (value, icon, title, classname, id) =>
    Utils.execAsync([
        "notify-send",
        `${title} changed`,
        `${title}: ${value}%`,
        "-h",
        `string:class:${classname}`,
        "-h",
        `int:value:${value}`,
        "-h",
        `string:value-icon:${icon}`,
        "-h",
        "boolean:hide-header:true",
        "-h",
        "boolean:hide-body:true",
        "-e",
        ...(id ? ["-r", id.toString()] : ["-p"]),
    ]);
