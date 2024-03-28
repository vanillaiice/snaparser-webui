<script lang="ts">
	import 'beercss';
	import theme from '$lib/theme';
	import github from 'svelte-highlight/styles/github';
	import githubDark from 'svelte-highlight/styles/github-dark';

	let themeLight: boolean;
	let highlightTheme: string;
	$: {
		themeLight = $theme === 'light';
		highlightTheme = themeLight ? github : githubDark;
		document.body.className = $theme;
	}
</script>

<svelte:head>
	{@html highlightTheme}
</svelte:head>

<header class="fill fixed">
	<nav>
		<h5 class="max">
			<a href="/">Snaparser</a>
			<img class="tiny margin" src="/favicon.png" alt="Snaparser logo" />
		</h5>
		<a
			class="button circle transparent"
			href="https://github.com/vanillaiice/snaparser_webui"
			target="_blank"
		>
			<i>
				<img src="/github.svg" alt="github" />
			</i>
		</a>
		<a class="button circle transparent" href="https://twitter.com/vanillaiiceee" target="_blank">
			<i>
				<img src="/x.svg" alt="twitter" />
			</i>
		</a>
		<a
			class="button circle transparent"
			on:click={() => {
				themeLight ? ($theme = 'dark') : ($theme = 'light');
			}}
		>
			<label class="switch icon">
				<input type="checkbox" checked={themeLight} />
				<span>
					<i>light_mode</i>
				</span>
			</label>
		</a>
	</nav>
</header>

<main class="responsive">
	<slot />
</main>

<footer class="fixed fill">
	<section class="center-align">
		<a class="no-margin center-align" href="/about">about</a>
		~
		<a class="no-margin center-align" href="/privacy">privacy</a>
	</section>
	<section class="center-align">
		<a class="no-margin center-align link" href="https://github.com/vanillaiice" target="_blank"
			>&copy; 2024 🍦 vanillaiice</a
		>
		~ made with
		<a class="no-margin center-align link" href="https://beercss.com" target="_blank"> beercss </a>
		&amp;
		<a class="button circle transparent no-margin" href="https://kit.svelte.dev/" target="_blank">
			<img class="tiny" src="/svelte-logo.svg" alt="sveltejs Logo" />
		</a>
	</section>
</footer>
