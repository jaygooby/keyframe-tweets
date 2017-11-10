# About
I'm using this system to extract images from a video stream so I can add the images to my live tweets, without needing to also hold a camera.

The ffmpeg command extracts [i-frames](https://en.wikipedia.org/wiki/Video_compression_picture_types#Intra-coded_.28I.29_frames.2Fslices_.28key_frames.29) so I should be able to capture slide changes, etc.

# Components
My setup is an old iPhone 4 on a [tripod plus a zoom lens](https://www.amazon.co.uk/gp/product/B00AQUIBUA/ref=oh_aui_detailpage_o03_s00?ie=UTF8&psc=1), running [Larix Broadcaster](https://wmspanel.com/larix_broadcaster) - a free app with no restrictions on broadcasting time. You don't need to use an iPhone; you just need a device that can push a video stream to an rtmp url; a Raspberry Pi with a camera would work just as well.

The Larix app sends an [rtmp](https://en.wikipedia.org/wiki/Real-Time_Messaging_Protocol) stream to an instance of [nginx](http://nginx.org/) running on my laptop that's been compiled with the [nginx rtmp streaming module](https://github.com/arut/nginx-rtmp-module). The [nginx config](./rtmp.conf) is really basic and just rebroadcasts this stream.

If you want to try this yourself, use my [build-nginx script](https://github.com/jaygooby/build-nginx) to get a custom nginx setup:

```
build-nginx -m https://github.com/arut/nginx-rtmp-module.git@v1.2.0
```

I then point [ffmpeg](https://www.ffmpeg.org/) at the nginx stream and it extracts the images into a folder named after the speaker; all this is done through a simple [Makefile](./Makefile).

The last component is the networking. I need the the iPhone to stream nicely to my laptop, and I don't want to rely on the venue wifi, and I can't use mobile data, because the rtmp stream needs to connect to my laptop's IP, so instead I've got a [Netgear N300 wifi range extender](https://www.amazon.co.uk/NETGEAR-Extender-External-Antennas-EX2700-100UKS/dp/B00NIUHAG6/ref=pd_lpo_vtph_147_bs_lp_tr_t_1?_encoding=UTF8&psc=1&refRID=8JRBPGWVJG39BS27H2JC) which both my laptop and the iPhone 4 connect to.

I can configure the Netgear to use the venue wifi or use another phone's hotspot for the actual internet connection.

# Capturing images from the video feed
## Get the rtmp url
You'll need to know what RTMP URL to stream your video to. On the laptop where you'll be running nginx, use the Makefile to show it to you:

```
make url
```

or if you know which network adapter you want to use:

```
ETH=eth1 make url
```

This will output a url like `rtmp://10.10.10.1/live/tweets` enter this into the Larix app (or whatever streaming video capture software you're using).

## Start the capture
Now you know the url, and presuming that you've started nginx and are now streaming video to it from your camera or device, you'll want to start grabbing frames.

Just call:

```
make
```

or again, if you're using a different adapter,

```
ETH=eth1 make
```

This will create a folder called something like `stills/1510321049` where the numerical directory is just the epoch seconds timestamp for when you ran the command.

If you'd like a nicer name, call it like this:

```
SPEAKER=jay make
```

This will instead make a folder called `stills/jay` containing the video stills.
