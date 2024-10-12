const bluetooth = await Service.import("bluetooth");

bluetooth.connect(
    "device-added",
    (bluetooth, /** @type {string} */ address) => {
        if (App.getWindow("bluetooth")?.visible) return;

        const device = bluetooth.getDevice(address);

        if (!device?.connected) return;

        Utils.notify({
            transient: true,
            summary: `${device?.name} connected`,
        });
    }
);

bluetooth.connect(
    "device-removed",
    (bluetooth, /** @type {string} */ address) => {
        if (App.getWindow("bluetooth")?.visible) return;

        const device = bluetooth.getDevice(address);

        Utils.notify({
            transient: true,
            summary: `${device?.name} disconnected`,
        });
    }
);

export {};
