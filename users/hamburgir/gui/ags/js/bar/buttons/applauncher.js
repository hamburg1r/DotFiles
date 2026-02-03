import PanelButton from "../PanelButton.js";

export default () => PanelButton({
	class_name: "applauncher",
	// on_clicked: () => Utils.execAsync(['rofi', '-modi', 'drun, combi', '-show', 'drun'])
	// 	.then(out => print(out))
	// 	.catch(err => print(err)),
	on_clicked: () => App.ToggleWindow('applauncher'),
	content: Widget.Box ({
		child: Widget.Icon(),
	})
})
