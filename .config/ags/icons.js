import { iconRange } from "./utils.js";
import * as chars from "./chars.js";

export const batteryIcons = [
    chars.BATTERY_OUTLINE,
    chars.BATTERY_10,
    chars.BATTERY_20,
    chars.BATTERY_30,
    chars.BATTERY_40,
    chars.BATTERY_50,
    chars.BATTERY_60,
    chars.BATTERY_70,
    chars.BATTERY_80,
    chars.BATTERY_90,
    chars.BATTERY,
];

export const batteryChargingIcons = [
    chars.BATTERY_CHARGING_OUTLINE,
    chars.BATTERY_CHARGING_10,
    chars.BATTERY_CHARGING_20,
    chars.BATTERY_CHARGING_30,
    chars.BATTERY_CHARGING_40,
    chars.BATTERY_CHARGING_50,
    chars.BATTERY_CHARGING_60,
    chars.BATTERY_CHARGING_70,
    chars.BATTERY_CHARGING_80,
    chars.BATTERY_CHARGING_90,
    chars.BATTERY_CHARGING_100,
];

export const brightnessIcons = [
    chars.BRIGHTNESS_5,
    chars.BRIGHTNESS_6,
    chars.BRIGHTNESS_7,
];

export const volumeIcons = [
    chars.VOLUME_LOW,
    chars.VOLUME_MEDIUM,
    chars.VOLUME_HIGH,
];

export const wifiIcons = [
    chars.WIFI_STRENGTH_OUTLINE,
    chars.WIFI_STRENGTH_1,
    chars.WIFI_STRENGTH_2,
    chars.WIFI_STRENGTH_3,
    chars.WIFI_STRENGTH_4,
];

/**
 * @param {boolean} charging
 * @param {number} percent
 * @returns {string}
 */
export const batteryRange = (charging, percent) =>
    iconRange(charging ? batteryChargingIcons : batteryIcons, percent / 100);

/**
 * @param {number} brightness
 * @returns {string}
 */
export const brightnessRange = (brightness) =>
    iconRange(brightnessIcons, brightness);

/**
 * @param {number} volume
 * @returns {string}
 */
export const volumeRange = (volume) => iconRange(volumeIcons, volume);

/**
 * @param {number} strength
 * @returns {string}
 */
export const wifiRange = (strength) => iconRange(wifiIcons, strength / 100);
