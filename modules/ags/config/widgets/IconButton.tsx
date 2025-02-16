import { ButtonProps } from "astal/gtk3/widget";

export default function IconButton({ className, ...rest }: ButtonProps) {
    return <button className={`icon ${className}`} {...rest} />;
}
