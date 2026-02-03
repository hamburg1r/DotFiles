// export default (monitor = 0) => Widget.Window({
// 	monitor,
// 	name: `powerMenu${monitor}`,
// 	keymode: "on-demand",
// 	layer: 'bottom',
// 	anchor: [ "top", "bottom", "left", "right" ],
// })
import PopupWindow from "../misc/PopupWindow.js";

function symbol(icon) {
	return `system-${icon}-symbolic`
}

export function poweroff() {
	return Widget.Button({
		child: Widget.Icon({
			icon: symbol("shutdown")
		}),
		on_primary_click: () => print("shutdown?")
	})
}

export function reboot() {
	return Widget.Button({
		child: Widget.Icon({
			icon: symbol("reboot")
		}),
		on_primary_click: () => print("reboot?")
	})
}

export function logOut() {
	return Widget.Button({
		child: Widget.Icon({
			icon: symbol("log-out")
		}),
		on_primary_click: () => print("log out?")
	})
}


export default (monitor = 0) => PopupWindow({
	name: `powerMenu${monitor}`,
	class_name: `powermenu`,
	anchor: [ "top", "right", "bottom", "left" ],
	child: Widget.Box({
		vertical: true,
		children: [
			poweroff(),
			reboot(),
			logOut(),
		],
	}),
})
