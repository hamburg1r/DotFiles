import AgsWindow from 'resource:///com/github/Aylur/ags/widgets/window.js';
import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import options from '../options.js';
import GObject from 'gi://GObject';

const keyGrabber = Widget.Window({
    name: 'key-grabber',
    anchor: ['top', 'left', 'right', 'bottom'],
    css: 'background-color: transparent;',
    visible: false,
    exclusivity: 'ignore',
    keymode: 'on-demand',
    layer: 'top',
    attribute: { list: [] },
    setup: self => self.on('notify::visible', ({ visible }) => {
        if (!visible)
            self.attribute?.list.forEach(name => App.closeWindow(name));
		self.keybind("Escape", () => App.closeWindow(name))
    }),
    child: Widget.EventBox({ vexpand: true }).on('button-press-event', () => {
        App.closeWindow('key-grabber');
        keyGrabber.attribute?.list.forEach(name => App.closeWindow(name));
    }),
});

// add before any PopupWindow is instantiated
App.addWindow(keyGrabber);

export class PopupWindow extends AgsWindow {
    static { GObject.registerClass(this); }

    constructor({ name, child, transition = 'crossfade', visible = false, ...rest }) {
        super({
            ...rest,
            name,
            keymode: 'exclusive',
            layer: 'overlay',
            class_names: ['popup-window', name],
			setup: (self) => {
				self.keybind("Escape", () => App.closeWindow(name))
			}
        });

        child.toggleClassName('window-content');
        this.revealer = Widget.Revealer({
            transition,
            child,
            // transition_duration: options.transition.value,
			transition_duration: 50,
            setup: self => self.hook(App, (_, wname, visible) => {
                if (wname === name)
                    this.revealer.reveal_child = visible;
            }),
        });

        this.child = Widget.Box({
            css: 'padding: 1px;',
            child: this.revealer,
        });

        this.show_all();
        this.visible = visible;

        keyGrabber.bind('visible', this, 'visible');
        keyGrabber.attribute?.list.push(name);
    }

    set transition(dir) { this.revealer.transition = dir; }
    get transition() { return this.revealer.transition; }
}

/** @param {import('types/widgets/window').WindowProps & {
 *      name: string
 *      child: import('types/widgets/box').default
 *      transition?: import('types/widgets/revealer').RevealerProps['transition']
 *  }} config
 */
export default config => new PopupWindow(config);
// import { type WindowProps } from "types/widgets/window"
// import { type RevealerProps } from "types/widgets/revealer"
// import { type EventBoxProps } from "types/widgets/eventbox"
// import type Gtk from "gi://Gtk?version=3.0"
// import options from "options"
//
// type Transition = RevealerProps["transition"]
// type Child = WindowProps["child"]
//
// type PopupWindowProps = Omit<WindowProps, "name"> & {
//     name: string
//     layout?: keyof ReturnType<typeof Layout>
//     transition?: Transition,
// }
//
// export const Padding = (name: string, {
//     css = "",
//     hexpand = true,
//     vexpand = true,
// }: EventBoxProps = {}) => Widget.EventBox({
//     hexpand,
//     vexpand,
//     can_focus: false,
//     child: Widget.Box({ css }),
//     setup: w => w.on("button-press-event", () => App.toggleWindow(name)),
// })
//
// const PopupRevealer = (
//     name: string,
//     child: Child,
//     transition: Transition = "slide_down",
// ) => Widget.Box(
//     { css: "padding: 1px;" },
//     Widget.Revealer({
//         transition,
//         child: Widget.Box({
//             class_name: "window-content",
//             child,
//         }),
//         transitionDuration: options.transition.bind(),
//         setup: self => self.hook(App, (_, wname, visible) => {
//             if (wname === name)
//                 self.reveal_child = visible
//         }),
//     }),
// )
//
// const Layout = (name: string, child: Child, transition?: Transition) => ({
//     "center": () => Widget.CenterBox({},
//         Padding(name),
//         Widget.CenterBox(
//             { vertical: true },
//             Padding(name),
//             PopupRevealer(name, child, transition),
//             Padding(name),
//         ),
//         Padding(name),
//     ),
//     "top": () => Widget.CenterBox({},
//         Padding(name),
//         Widget.Box(
//             { vertical: true },
//             PopupRevealer(name, child, transition),
//             Padding(name),
//         ),
//         Padding(name),
//     ),
//     "top-right": () => Widget.Box({},
//         Padding(name),
//         Widget.Box(
//             {
//                 hexpand: false,
//                 vertical: true,
//             },
//             PopupRevealer(name, child, transition),
//             Padding(name),
//         ),
//     ),
//     "top-center": () => Widget.Box({},
//         Padding(name),
//         Widget.Box(
//             {
//                 hexpand: false,
//                 vertical: true,
//             },
//             PopupRevealer(name, child, transition),
//             Padding(name),
//         ),
//         Padding(name),
//     ),
//     "top-left": () => Widget.Box({},
//         Widget.Box(
//             {
//                 hexpand: false,
//                 vertical: true,
//             },
//             PopupRevealer(name, child, transition),
//             Padding(name),
//         ),
//         Padding(name),
//     ),
//     "bottom-left": () => Widget.Box({},
//         Widget.Box(
//             {
//                 hexpand: false,
//                 vertical: true,
//             },
//             Padding(name),
//             PopupRevealer(name, child, transition),
//         ),
//         Padding(name),
//     ),
//     "bottom-center": () => Widget.Box({},
//         Padding(name),
//         Widget.Box(
//             {
//                 hexpand: false,
//                 vertical: true,
//             },
//             Padding(name),
//             PopupRevealer(name, child, transition),
//         ),
//         Padding(name),
//     ),
//     "bottom-right": () => Widget.Box({},
//         Padding(name),
//         Widget.Box(
//             {
//                 hexpand: false,
//                 vertical: true,
//             },
//             Padding(name),
//             PopupRevealer(name, child, transition),
//         ),
//     ),
// })
//
// export default ({
//     name,
//     child,
//     layout = "center",
//     transition,
//     exclusivity = "ignore",
//     ...props
// }: PopupWindowProps) => Widget.Window<Gtk.Widget>({
//     name,
//     class_names: [name, "popup-window"],
//     setup: w => w.keybind("Escape", () => App.closeWindow(name)),
//     visible: false,
//     keymode: "on-demand",
//     exclusivity,
//     layer: "top",
//     anchor: ["top", "bottom", "right", "left"],
//     child: Layout(name, child, transition)[layout](),
//     ...props,
// })
