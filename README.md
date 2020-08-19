# zoom-scheduler

Simple Node.js script to automatically open Zoom meetings on macOS for school. Class days, times, links and other information is stored in data.json which is parsed and waiter.js can be run to set up a scheduler for all of these times, and index.js can be run to search for current class if a scheduler is not needed.

To run, download the repository and run: `npm install`. Then `node index.js` to run the tool once, or `node waiter.js` to set up the scheduler.
