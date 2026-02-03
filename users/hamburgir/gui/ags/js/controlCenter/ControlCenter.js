import PopupWindow from "../misc/PopupWindow.js";
import NotificationColumn from "./NotificationColumn.js";
import {  MicIndicator, MicSlider, VolumeIndicator, VolumeSlider } from "../widgets/volume.js"

export default (monitor = 0) => PopupWindow({
	name: 'control-center',
	class_name: `control-center${monitor}`,
	anchor: [ "right", "top" ],
	child: Widget.Box({
		class_name: "controlCenter",
		vertical: true,
		children: [
			Widget.Box({
				children: [
					VolumeIndicator(),
					VolumeSlider(),
				]
			}),
			Widget.Box({
				children: [
					MicIndicator(),
					MicSlider(),
				]
			}),
			Widget.Separator({orientation: 0}),
			NotificationColumn(),
		],
	}),
})
