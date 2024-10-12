const Calendar = () =>
    Widget.Window({
        name: `calendar`,
        anchor: ["bottom", "right"],
        margins: [16],
        visible: false,
        child: Widget.Scrollable({
            classNames: ["calendar-window", "info-window"],
            vscroll: "automatic",
            hscroll: "never",
            child: Widget.Box({
                vertical: true,
                spacing: 16,
                children: [
                    Widget.Calendar({
                        hexpand: true,
                        vexpand: true,
                        noMonthChange: true,
                    }),
                ],
            }),
        }),
    });

export const toggleCalendar = () => App.toggleWindow("calendar");

export default Calendar;
