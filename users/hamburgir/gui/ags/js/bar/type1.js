import clients from './buttons/client.js'
import ControlCenter from './buttons/controlCenter.js'
import clock from '../services/clock.js'
import applauncher from './buttons/applauncher.js'
const Battery = await Service.import('battery')

const left = () => Widget.Box({
	class_name: 'left',
	children: [
		applauncher(),
		clients()
	],
})

const center = () => Widget.Box({
	class_name: 'center',
	children: [
		Widget.Label({
			label: clock.bind('time').as(t => `${t.format('%r')}`)
		}),
		// Widget.Label({
		// 	label: clock.time.format("%r")
		// })
	],
})

const right = () => Widget.Box({
	class_name: 'right',
	hpack: "end",
	children: [
		// Widget.Box({expand: true,}),
		ControlCenter(),
		Widget.Label({
			label: Battery.bind('percent').as(p => `󰁹${p}%`),
			visible: Battery.bind('available')
		})
	],
})

export default (monitor = 0) => Widget.Window({
	monitor,
	exclusivity: "exclusive",
	name: `bar${monitor}`,
	classNames: [ `bar${monitor}` ],
	anchor: [ "top", "left", "right" ],
	child: Widget.CenterBox({
		startWidget: left(),
		centerWidget: center(),
		endWidget: right(),
	})
})
