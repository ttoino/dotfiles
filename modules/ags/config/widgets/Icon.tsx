export default function Icon({
    class: className,
    ...rest
}: JSX.IntrinsicElements["label"]) {
    return <label class={`icon ${className}`} {...rest} />;
}
