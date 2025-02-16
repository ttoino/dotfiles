import Notifd from "gi://AstalNotifd";
import { execAsync } from "astal";

export const urgencyToString = {
    [Notifd.Urgency.LOW]: "low",
    [Notifd.Urgency.NORMAL]: "normal",
    [Notifd.Urgency.CRITICAL]: "critical",
};

export const typeToHintType = {
    string: "string",
    number: "int",
    boolean: "boolean",
};

export interface NotifyArguments {
    title: string;
    body?: string;
    urgency?: Notifd.Urgency;
    expireTime?: number;
    appName?: string;
    icon?: string;
    category?: string | string[];
    transient?: boolean;
    hint?: Record<string, string | number | boolean>;
    id?: string;
    action?: Record<string, string>;

    // Extensions (not part of the spec)
    className?: string;
    hideBody?: boolean;
    hideHeader?: boolean;
    image?: string;
    slider?: number | { value: number; icon?: string };
}

export const notify = ({
    title,
    body,
    urgency,
    expireTime,
    appName,
    icon,
    category,
    transient,
    hint = {},
    id,
    action = {},
    className,
    hideBody,
    hideHeader,
    image,
    slider,
}: NotifyArguments) => {
    const args = ["notify-send", "--print-id"];

    // Custom hints
    if (className) hint["class"] = className;
    if (hideBody) hint["hide-body"] = hideBody;
    if (hideHeader) hint["hide-header"] = hideHeader;
    if (image) hint["image-path"] = image;
    if (slider) {
        if (typeof slider === "number") hint["value"] = slider;
        else {
            hint["value"] = slider.value;
            if (slider.icon) hint["value-icon"] = slider.icon;
        }
    }

    if (urgency) args.push(`--urgency=${urgencyToString[urgency]}`);
    if (expireTime) args.push(`--expire-time=${expireTime}`);
    if (appName) args.push(`--app-name=${appName}`);
    if (icon) args.push(`--icon=${icon}`);
    if (category)
        args.push(
            `--category=${
                Array.isArray(category) ? category.join(",") : category
            }`
        );
    if (transient) args.push("--transient");
    args.push(
        ...Object.entries(hint).map(
            ([key, value]) =>
                `--hint=${
                    typeToHintType[typeof value as keyof typeof typeToHintType]
                }:${key}:${value}`
        )
    );
    if (id) args.push(`--replace-id=${id}`);
    args.push(
        ...Object.entries(action).map(
            ([key, value]) => `--action=${key}=${value}`
        )
    );

    args.push(title);
    if (body) args.push(body);

    return execAsync(args);
};
