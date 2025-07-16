import app from "ags/gtk4/app";
import "./services/notifications";
import * as windows from "./services/windows";
import style from "./style/main.scss";

app.start({
    css: style,
    main() {
        windows.init();
    },
    requestHandler(request, res) {
        const args = request.split(/\s+/);
        const [action, ...params] = args;

        switch (action.toLowerCase()) {
            case "popup":
                const [subaction, ...popup] = params;

                switch (subaction.toLowerCase()) {
                    case "show":
                        windows.showPopup(popup.join(" "));
                        return res(`Showed ${popup.join(" ")}`);
                    case "toggle":
                        windows.togglePopup(popup.join(" "));
                        return res(`Toggled ${popup.join(" ")}`);
                    case "dismiss":
                        windows.dismissPopup();
                        return res("Dismissed popups");
                }
                return res("Invalid popup action");
        }

        res("Invalid action");
    },
});
