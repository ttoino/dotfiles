const FORMATTER = new Intl.DateTimeFormat([], {
    year: "2-digit",
    month: "numeric",
    day: "numeric",
    weekday: "short",
    hour: "numeric",
    minute: "numeric",
    second: "numeric",
    hour12: false,
});

const dateObject = () => {
    const date = new Date();
    const parts = FORMATTER.formatToParts(date);
    const ret = {
        date,
        year: "",
        month: "",
        day: "",
        weekday: "",
        hour: "",
        minute: "",
        second: "",
    };

    for (const part of parts) {
        if (part.type === "literal") continue;

        ret[part.type] = part.value;
    }

    return ret;
};

export default Variable(dateObject(), {
    poll: [1000, dateObject],
});
