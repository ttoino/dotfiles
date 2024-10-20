import * as chars from "./chars";

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
] as const;

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
] as const;

export const brightnessIcons = [
    chars.BRIGHTNESS_5,
    chars.BRIGHTNESS_6,
    chars.BRIGHTNESS_7,
] as const;

export const volumeIcons = [
    chars.VOLUME_LOW,
    chars.VOLUME_MEDIUM,
    chars.VOLUME_HIGH,
] as const;

export const wifiIcons = [
    chars.WIFI_STRENGTH_OUTLINE,
    chars.WIFI_STRENGTH_1,
    chars.WIFI_STRENGTH_2,
    chars.WIFI_STRENGTH_3,
    chars.WIFI_STRENGTH_4,
] as const;

export const iconRange = (icons: readonly string[], value: number) => {
    const index = Math.min(
        Math.max(0, Math.floor(value * icons.length)),
        icons.length - 1
    );
    return icons[index];
};

export const batteryRange = (charging: boolean, percent: number) =>
    iconRange(charging ? batteryChargingIcons : batteryIcons, percent);

export const brightnessRange = (brightness: number) =>
    iconRange(brightnessIcons, brightness);

export const volumeRange = (volume: number) => iconRange(volumeIcons, volume);

export const wifiRange = (strength: number) =>
    iconRange(wifiIcons, strength / 100);
