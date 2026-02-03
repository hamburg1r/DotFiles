import { Audio } from "resource:///com/github/Aylur/ags/service/audio.js"
// export default (typ = "micInd") => {
// 	const audio = Audio
//
// 	/** @param {'speaker' | 'microphone'} type */
// 	const VolumeSlider = (type = 'speaker') => Widget.Slider({
// 		hexpand: true,
// 		drawValue: false,
// 		onChange: ({ value }) => audio[type].volume = value,
// 		value: audio[type].bind('volume'),
// 	})
//
// 	const speakerSlider = VolumeSlider('speaker')
// 	const micSlider = VolumeSlider('microphone')
//
// 	const volumeIndicator = Widget.Button({
// 		on_clicked: () => audio.speaker.is_muted = !audio.speaker.is_muted,
// 		child: Widget.Icon().hook(audio.speaker, self => {
// 			const vol = audio.speaker.volume * 100;
// 			const icon = [
// 				[101, 'overamplified'],
// 				[67, 'high'],
// 				[34, 'medium'],
// 				[1, 'low'],
// 				[0, 'muted'],
// 			].find(([threshold]) => threshold <= vol)?.[1];
//
// 			self.icon = `audio-volume-${icon}-symbolic`;
// 			self.tooltip_text = `Volume ${Math.floor(vol)}%`;
// 		}),
// 	})
// }
const audio = await Service.import('audio')

export function MicIndicator() {
	return Widget.Button({
		on_clicked: () => audio.microphone.is_muted = !audio.microphone.is_muted,
		child: Widget.Icon().hook(audio.microphone, self => {
			const vol = audio.microphone.volume * 100;
			const icon = [
				[101, 'overamplified'],
				[67, 'high'],
				[34, 'medium'],
				[1, 'low'],
				[0, 'muted'],
			].find(([threshold]) => threshold <= vol)?.[1];

			self.icon = `audio-input-microphone-${icon}-symbolic`;
			self.tooltip_text = `Volume ${Math.floor(vol)}%`;
		}),
	})
}

export function MicSlider() {
	return Widget.Slider({
		hexpand: true,
		drawValue: false,
		onChange: ({ value }) => audio.microphone.volume = value,
		value: audio.microphone.bind('volume'),
	})
}

export function VolumeIndicator() {
	return Widget.Button({
		on_clicked: () => audio.speaker.is_muted = !audio.speaker.is_muted,
		child: Widget.Icon().hook(audio.speaker, self => {
			const vol = audio.speaker.volume * 100;
			const icon = [
				[101, 'overamplified'],
				[67, 'high'],
				[34, 'medium'],
				[1, 'low'],
				[0, 'muted'],
			].find(([threshold]) => threshold <= vol)?.[1];

			self.icon = `audio-volume-${icon}-symbolic`;
			self.tooltip_text = `Volume ${Math.floor(vol)}%`;
		}),
	})
}

export function VolumeSlider() {
	return Widget.Slider({
		hexpand: true,
		drawValue: false,
		onChange: ({ value }) => audio.speaker.volume = value,
		value: audio.speaker.bind('volume'),
	})
}
