# ODevs Presents - Ignite the Holidays - Ignite Decks

These are the Ignite Decks for Ignite the Holidays.

You should have 20 slides without an introduction slide (or can if you need, but it will automatically have a standard one with your title and name).

Each slide will automatically advance with this tool every 15 seconds. One nice thing about this tool is that it does have a little "counter" so you know in relative terms how much longer that slide will be displayed.

If you have ANY questions, please reach out to me directly in Slack!

## IMPORTANT IGNITE THE HOLIDAYS PARTICIPANTS INFORMATION

In order for me to generate the automatically advancing slide decks, I need a bit of your help.

Clone this repo and create a fork.

You will find a folder in this repository called `resources\images\(your-presentation)`. In that folder, if you could drop your 20 images of your slides, a script will auto-generate the slide deck and present it using some of the magic mentioned below.

Depending on what you built your slide deck in, you might be able to export the slides to images. That will make it easy. I did mine by doing a full screen presentation and then screen-shooting each one. It was relatively quick for me because it automatically saved each one in a folder then I just moved them (and remove the stupid space in the name, dumb Windows.) See below.

> NOTE: Please include .jpg or .png images only. ALSO - File names ***cannot contain spaces***, or bad things happen.

Once you put them in the folder, push it back to this repo and submit a *PR*. Don't worry about compiling it, unless you want to play around with this for your own use. To do so, follow the directions below and then you can just run the `(your-presentation).sh` file and then `grunt serve`

> LAST NOTE: **PLEASE PLEASE** - Don't peak in the `improv-` folders. I know, they are right there and very tempting, but I'd love you have all of you help with Improv (karaoke) as well, so that would be cheating. You are all happy to fork this repo and use it down the road if you wish.

## Thank you

I want to thank you all for participating in Ignite the Holidays. I'm actually pretty excited about using this "tool" to present it.  

___

## About (From the original writer)

This repo provides tools to allow someone to run a series of Ignite Karaokes.

Ignite Karaokes follow the [Ignite (Enlighten us, but make it quick)](http://www.ignitetalks.io/) format -- 20 slides, each slide is up for 15 seconds. But with a twist... you don't know what slides will appear!

## Thanks and Credits

> "If I have seen further it is by standing on the shoulders of Giants." -- Isaac Newton

It is built on the shoulders of:

* [hakimel/reveal.js: The HTML Presentation Framework](https://github.com/hakimel/reveal.js#slide-backgrounds)
* [slara/generator-reveal: Yeoman generator for Reveal.js](https://github.com/slara/generator-reveal)
* [Unsplash - The internet's source of freely usable images.](https://unsplash.com)

## Configuration

1. In order to run this, you need `npm`, `grunt`, and `bower` installed. (`npm install -g grunt`, `npm install -g bower`)
2. The script which randomizes things requires `bash` and `shuf`
3. Execute the following: `npm install && bower install`
4. Copy image files into `resources/images/ignite`; you need at least 20. The more the better! There are some sample files in the directory.

## Usage

1. Start the server with `grunt serve`
2. In the lower left, click on the "play" button to start. The first slide will be up for 5 seconds, afterwards there are 20 slides which are up for 15 seconds each.
3. To refresh and rewind, execute the `refill.sh` script.

## Presenters and Order

| Presenter         | Presentation                                                                 | Time  |
| ----------------- | ---------------------------------------------------------------------------- | ----- |
| George Westwater  | Chef CI/CD: Sizzling Success with 1,200+ Pipelines, 13K Builds/Day, and You! | 9:35  |
| Dan-Joe Lopez     | How to Fail a Cookbook Code Review                                           | 9:40  |
| Mike Butler       | How to Solve a Rubik's Cube                                                  | 9:45  |
| Heather Thacker   | Pastry Chef to Progress Chef                                                 | 10:15 |
| Milan Šťastný     | Automate Everything                                                          | 10:20 |
| Stephanie Laingen | The Worst                                                                    | 10:25 |
| Ignite Improv     | What I've Learned from Community                                             | 11:00 |
| Ignite Improv     | Should Kids be taught DevOps                                                 | 11:05 |
| Ignite Improv     | Lint This!                                                                   | 11:10 |
| Ignite Improv     | One More Round?                                                              | 11:15 |
