import { LabelProps } from "astal/gtk3/widget";

export default function Icon({ className, ...rest }: LabelProps) {
    return <label className={`icon ${className}`} {...rest} />;
}
