import { browser } from '$app/environment';
import { writable } from 'svelte/store';

const defaultTheme = 'light';
const initialTheme = browser ? window.localStorage.getItem('theme') ?? defaultTheme : defaultTheme;

const theme = writable<string>(initialTheme);

theme.subscribe((value) => {
	if (browser) {
		window.localStorage.setItem('theme', value);
	}
});

export default theme;
