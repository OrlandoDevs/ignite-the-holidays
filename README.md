# ODevs Presents - Ignite the Holidays - Ignite Decks

These are the Ignite Decks for Ignite the Holidays.

You should have 20 slides without an introduction slide (or can if you need, but it will automatically have a standard one with your title and name).

Each slide will automatically advance with this tool every 15 seconds. One nice thing about this tool is that it does have a little "counter" so you know in relative terms how much longer that slide will be displayed.

If you have ANY questions, please reach out to me directly in Slack!

## IMPORTANT IGNITE THE HOLIDAYS PARTICIPANTS INFORMATION

In order for me to generate the automatically advancing slide decks, I need a bit of your help.

Clone this repo (or) create a fork. Shoot me your github ID and I'll just add it to this repo for write privs.

You will find a folder in this repository called `resources\images\(your-presentation)`. In that folder, if you could drop your 20 images of your slides, a script will auto-generate the slide deck and present it using some of the magic mentioned below.

Depending on what you built your slide deck in, you might be able to export the slides to images. That will make it easy. I did mine by doing a full screen presentation and then screen-shooting each one. It was relatively quick for me because it automatically saved each one in a folder then I just moved them (and remove the stupid space in the name, dumb Windows.) See below.

Also, please remove the file called `deleteme` in your folder. This was temporary in order for the folder to be pushed to GitHub.

> NOTE: Please include .jpg or .png images only. ALSO - File names **_cannot contain spaces_**, or bad things happen.

Once you put them in the folder, push it back to this repo and submit a _PR_. Don't worry about compiling it, unless you want to play around with this for your own use. To do so, follow the directions below and then you can just run the `(your-presentation).sh` file and then `npm run dev`

> LAST NOTE: **PLEASE PLEASE** - Don't peak in the `improv-` folders. I know, they are right there and very tempting, but I'd love you have all of you help with Improv (karaoke) as well, so that would be cheating. You are all happy to fork this repo and use it down the road if you wish.

## Thank you

I want to thank you all for participating in Ignite the Holidays. I'm actually pretty excited about using this "tool" to present it.

---

## About (From the original writer)

This repo provides tools to allow someone to run a series of Ignite Karaokes.

Ignite Karaokes follow the [Ignite (Enlighten us, but make it quick)](http://www.ignitetalks.io/) format -- 20 slides, each slide is up for 15 seconds. But with a twist... you don't know what slides will appear!

## Thanks and Credits

> "If I have seen further it is by standing on the shoulders of Giants." -- Isaac Newton

It is built on the shoulders of:

- [hakimel/reveal.js: The HTML Presentation Framework](https://github.com/hakimel/reveal.js#slide-backgrounds)
- [slara/generator-reveal: Yeoman generator for Reveal.js](https://github.com/slara/generator-reveal)
- [Unsplash - The internet's source of freely usable images.](https://unsplash.com)

### Installation

```bash
npm install
```

### Development

Start the development server with live reload:

```bash
npm run dev
# or
npm start
```

The presentation will be available at http://localhost:9000

### Building

Build the presentation for distribution:

```bash
npm run build
```

The output will be in the `dist/` directory.

### Testing

Run linting and build tests:

```bash
npm test
```

### Code Quality

Format and lint your code:

```bash
npm run format
npm run format:check
npm run lint
npm run lint:fix
```

### Other Commands

- `npm run clean` - Remove build artifacts
- `npm run prebuild` - Generate index.html from templates

## Presenters and Order

| Presenter             | Presentation                                                        | Time |
| --------------------- | ------------------------------------------------------------------- | ---- |
| Brian Rinaldi         | Welcome to Ignite the Holidays                                      | 7:30 |
| Will Gorman           | AO4SD - Accelerate Orlando for Software Developers                  | 7:35 |
| Jerry Reed            | Software Quilts                                                     | 7:40 |
| Robert Schneider      | How to Take Good Notes                                              | 7:45 |
| Rachel LaQuea         | Frequencies: an interactive sound therapy app                       | 7:50 |
| Mike Butler           | Zero Trust Given                                                    | 7:55 |
| Luis Felipe Hernandez | Unit testing the Linux Kernel                                       | 8:15 |
| Jianyu Wang           | Survive My First Year of Full-time Software Engineer                | 8:20 |
| Christopher Pecoraro  | When crisis sets in: How should we manage critical website changes? | 8:25 |
| William Cook          | Why Go?                                                             | 8:30 |
| Mark Prather          | Boundaries, Game Theory, and James Bond Villians                    | 8:35 |
