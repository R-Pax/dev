// Firefox's main config file 
// Settings needed for the custom theme to work are marked with "!!"

// -------------- Graphical preferences --------------

// !! Allow userChrome.css & userContent.css to modify Firefox's appearance
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// !! Allow the css themes to modify svg icons
user_pref("svg.context-properties.content.enabled", true);

// !! Use the operating system's native theme styling
user_pref("browser.theme.native-theme", true);

// -------------- Privacy & history --------------

// Disable Firefox's history database. (cookies still work)
user_pref("places.history.enabled", false);

// Disable saving/autocompletion of form entries, such as previously entered usernames
user_pref("browser.formfill.enable", false);

// Don't automatically clear browsing data when shut down
user_pref("privacy.sanitize.sanitizeOnShutdown", false);

// Disable all data collection settings
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("datareporting.usage.uploadEnabled", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.unified", false);

// -------------- New tab page settings --------------

// Hide sponsored top sites
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);

// Hide sponsored "content"/recommendations 
user_pref("browser.newtabpage.activity-stream.showSponsored", false);

// Hide sponsored content UI boxes and checkboxes
user_pref("browser.newtabpage.activity-stream.showSponsoredCheckboxes", false);

// Disable the top sites list
user_pref("browser.newtabpage.activity-stream.default.sites", "");

// Disable the top sites' feed 
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);

