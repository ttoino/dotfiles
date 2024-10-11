// https://github.com/luukdv/color.js/

var getSrc = (item) => (typeof item === "string" ? item : item.src);

var getArgs = ({
    amount = 3,
    format = "array",
    group = 20,
    sample = 10,
} = {}) => ({
    amount,
    format,
    group,
    sample,
});

var format = (input, args) => {
    var list = input.map((val) => {
        var rgb = Array.isArray(val) ? val : val.split(",").map(Number);
        return args.format === "hex" ? rgbToHex(rgb) : rgb;
    });
    return args.amount === 1 || list.length === 1 ? list[0] : list;
};

var group = (number, grouping) => {
    var grouped = Math.round(number / grouping) * grouping;
    return Math.min(grouped, 255);
};

var rgbToHex = (rgb) =>
    "#" +
    rgb
        .map((val) => {
            var hex = val.toString(16);
            return hex.length === 1 ? "0" + hex : hex;
        })
        .join("");

var getImageData = (src) =>
    new Promise((resolve, reject) => {
        var canvas = document.createElement("canvas");
        var context = canvas.getContext("2d");
        var img = new Image();

        img.onload = () => {
            canvas.height = img.height;
            canvas.width = img.width;
            context.drawImage(img, 0, 0);
            var data = context.getImageData(0, 0, img.width, img.height).data;
            resolve(data);
        };

        img.onerror = () => reject(Error("Image loading failed."));

        img.crossOrigin = "";
        img.src = src;
    });

var getAverage = (data, args) => {
    var gap = 4 * args.sample;
    var amount = data.length / gap;
    var rgb = {
        r: 0,
        g: 0,
        b: 0,
    };

    for (var i = 0; i < data.length; i += gap) {
        rgb.r += data[i];
        rgb.g += data[i + 1];
        rgb.b += data[i + 2];
    }

    return format(
        [
            [
                Math.round(rgb.r / amount),
                Math.round(rgb.g / amount),
                Math.round(rgb.b / amount),
            ],
        ],
        args
    );
};

var getProminent = (data, args) => {
    var gap = 4 * args.sample;
    var colors = {};

    for (var i = 0; i < data.length; i += gap) {
        var rgb = [
            group(data[i], args.group),
            group(data[i + 1], args.group),
            group(data[i + 2], args.group),
        ].join();
        colors[rgb] = colors[rgb] ? colors[rgb] + 1 : 1;
    }

    return format(
        Object.entries(colors)
            .sort(([_keyA, valA], [_keyB, valB]) => (valA > valB ? -1 : 1))
            .slice(0, args.amount)
            .map(([rgb]) => rgb),
        args
    );
};

var process = (handler, item, args) =>
    new Promise((resolve, reject) =>
        getImageData(getSrc(item))
            .then((data) => resolve(handler(data, getArgs(args))))
            .catch((error) => reject(error))
    );

var average = (item, args) => process(getAverage, item, args);

var prominent = (item, args) => process(getProminent, item, args);

export { average, prominent };
