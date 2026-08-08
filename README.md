# Status

This status page, based on the hugo theme 'cstate' will update itself every 5-15 minutes by making a HTTP request to some self hosted sites.

If a service is reported as down (HTTP server error code), an issue will automatically be created and the site will be rebuild in milliseconds (Thanks hugo!) and deployed on Cloudflare Pages.
In this way, the status page keeps up (relying on Cloudflare) even when my other server(s) are down.

I get notified by the RSS feed (which is included in cstate) myself!