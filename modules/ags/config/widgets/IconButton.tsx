export default function IconButton({
    class: className,
    ...rest
}: JSX.IntrinsicElements["button"]) {
    return <button class={`icon ${className}`} {...rest} />;
}
