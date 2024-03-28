<script lang="ts">
	import Highlight from 'svelte-highlight';
	import { json } from 'svelte-highlight/languages';

	let classSnackbar: string = '';
	let messageSnackbar: string = '';
	let showSnackbar: boolean = false;
	let loading: boolean = false;
	let fileContent: any = null;
	let formData: FormData;

	// TODO: use actual type instead of any
	let handleFile = (evt: any) => {
		let f = evt.target.files[0];
		const reader = new FileReader();
		reader.onload = function (evt: ProgressEvent<FileReader>) {
			if (evt.target && typeof evt.target.result === 'string') {
				const j = JSON.parse(evt.target.result);
				let a = {};
				for (const [k, v] of Object.entries(j)) {
					if (Array.isArray(v)) {
						a = { [k]: v.slice(0, 20) };
						break;
					} else {
						classSnackbar = 'snackbar error active';
						messageSnackbar = 'invalid chat history file';
						showSnackbar = true;
					}
				}
				const s = JSON.stringify(a, null, 2);
				fileContent = s;
			}
		};
		reader.readAsText(f);
	};

	// TODO: use actual type instead of any
	let parseChats = async (t: any) => {
		loading = true;
		formData = new FormData(t);
		fetch(import.meta.env.VITE_API_URL, {
			method: 'POST',
			body: formData
		})
			.then(async (result) => {
				if (!result.ok) {
					classSnackbar = 'snackbar error active';
					messageSnackbar = result.statusText + ': ' + (await result.text());
					showSnackbar = true;
					return null;
				}
				return result.blob();
			})
			.then((blob) => {
				if (blob != null) {
					classSnackbar = 'snackbar active';
					messageSnackbar = 'Downloading parsed chat file';
					showSnackbar = true;
					var url = window.URL.createObjectURL(blob);
					var a = document.createElement('a');
					a.href = url;
					a.download = 'chats.zip';
					document.body.appendChild(a);
					a.click();
					a.remove();
				}
			})
			.catch((err) => {
				classSnackbar = 'snackbar error active';
				messageSnackbar = err;
				showSnackbar = true;
			})
			.finally(() => {
				loading = false;
			});
	};
</script>

<h6 class="bold small margin">
	Step 1:&nbsp;<a
		class="link"
		href="https://help.snapchat.com/hc/en-us/articles/7012305371156-How-do-I-download-my-data-from-Snapchat"
		target="_blank">Download&nbsp;</a
	>your Snapchat history file (you only need the chat_history.json file).
</h6>

<h6 class="bold small margin">Step 2: Upload your Snapchat history file.</h6>

<form
	enctype="multipart/form-data"
	method="POST"
	on:submit={async (evt) => {
		evt.preventDefault();
		await parseChats(evt.target);
	}}
>
	<div class="field label prefix round fill border">
		<input type="file" accept=".json" name="file" on:change={handleFile} required />
		<input type="text" />
		<label for="file">Attach Snapchat Chat History File</label>
		<i>attach_file</i>
	</div>

	{#if !loading}
		<button type="submit" class="responsive extra small-elevate">Upload</button>
	{:else}
		<div class="center-align">
			<progress class="circle"></progress>
		</div>
	{/if}

	{#if showSnackbar}
		<div
			class={classSnackbar}
			on:click={() => {
				showSnackbar = false;
			}}
		>
			{messageSnackbar}
		</div>
	{/if}
</form>

{#if fileContent}
	<h6>Snippet of Snapchat chat history file:</h6>
	<Highlight language={json} code={fileContent} />
{/if}
