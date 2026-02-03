import ControlCenter from './js/controlCenter/ControlCenter.js'
import Notifications from './js/notifications/Notifications.js';
import App from "resource:///com/github/Aylur/ags/app.js"
import { monitorFile } from "resource:///com/github/Aylur/ags/utils/file.js"
import Bar from "./js/bar/TopBar.js"
import WorkspaceStrip from "./js/workspaceStrip/Workspaces.js"
import applauncher from './js/applauncher/applauncher.js';
import powerMenu from './js/powerMenu/powerMenu.js';
import { init } from './js/settings/setup.js';

// main scss file
const scss = `${App.configDir}/scss/main.scss`

// target css file
const css = `/tmp/ags/style.css`

// make sure sassc is installed on your system
Utils.exec(`mkdir -p /tmp/ags`)
Utils.execAsync(['sassc', scss, css ])
	.then(out => print(out))
	.catch(err => print(err));

monitorFile (
	`${App.configDir}/scss`,
	function() {
		// main scss file
		const scss = `${App.configDir}/scss/main.scss`

		// target css file
		const css = `/tmp/ags/style.css`

		// make sure sassc is installed on your system
		Utils.exec(`sassc ${scss} ${css}`)
		App.resetCss()
		App.applyCss(css)
	},
)

export default {
	style: css,
	onConfigParsed: init,
	windows: [
		applauncher(),
		Bar(),
		WorkspaceStrip(),
		ControlCenter(),
		Notifications(),
	],
}
