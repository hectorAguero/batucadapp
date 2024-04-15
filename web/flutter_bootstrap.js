function topInset() {
	Number.parseFloat(
		getComputedStyle(document.documentElement).getPropertyValue("--sat"),
	);
}

function rightInset() {
	return Number.parseFloat(
		getComputedStyle(document.documentElement).getPropertyValue("--sar"),
	);
}

function bottomInset() {
	return Number.parseFloat(
		getComputedStyle(document.documentElement).getPropertyValue("--sab"),
	);
}

function leftInset() {
	return Number.parseFloat(
		getComputedStyle(document.documentElement).getPropertyValue("--sal"),
	);
}
{{flutter_js}}
{{flutter_build_config}}
window.addEventListener("load", (_) => {
	_flutter.loader.load({
		config: {
			// Use the local CanvasKit bundle instead of the CDN to reduce test flakiness.
			canvasKitBaseUrl: "/canvaskit/",
		},
		onEntrypointLoaded: (engineInitializer) => {
			engineInitializer.initializeEngine().then((appRunner) => {
				appRunner.runApp().then((_) => {
					document
						.querySelector('meta[name="viewport"]')
						.setAttribute(
							"content",
							"width=device-width, initial-scale=1.0, viewport-fit=cover",
						);
				});
			});
		},
	});
});
