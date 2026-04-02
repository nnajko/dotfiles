// === Performance ===
user_pref("gfx.webrender.all", true);
user_pref("layers.acceleration.force-enabled", true);
user_pref("browser.cache.disk.enable", false);
user_pref("browser.cache.memory.capacity", 524288);
user_pref("network.http.max-persistent-connections-per-server", 10);
user_pref("browser.sessionstore.interval", 30000);
user_pref("dom.ipc.processCount", 8);

// === Hardware video decode (Intel Arc) ===
user_pref("media.ffmpeg.vaapi.enabled", true);

// === Wayland / Linux integration ===
user_pref("widget.use-xdg-desktop-portal.file-picker", 1);

// === Enable userChrome.css ===
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// === Disable bloat / telemetry ===
user_pref("extensions.pocket.enabled", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("toolkit.telemetry.enabled", false);
