# About
I'm using this system to extract images from a video stream so I can add the images to my live tweets, without needing to also hold a camera.

The ffmpeg command extracts [i-frames](https://en.wikipedia.org/wiki/Video_compression_picture_types#Intra-coded_.28I.29_frames.2Fslices_.28key_frames.29) so I should be able to capture slide changes, etc.

## Components
My setup is an old iPhone 4 on a [tripod plus a zoom lens](https://www.amazon.co.uk/gp/product/B00AQUIBUA/ref=oh_aui_detailpage_o03_s00?ie=UTF8&psc=1), running [Larix Broadcaster](https://wmspanel.com/larix_broadcaster) - a free app with no restrictions on broadcasting time.

The Larix app sends an [rtmp](https://en.wikipedia.org/wiki/Real-Time_Messaging_Protocol) stream to an instance of [nginx](http://nginx.org/) running on my laptop that's been compiled with the [nginx rtmp streaming module](https://github.com/arut/nginx-rtmp-module). The [nginx config](./rtmp.conf) is really basic and just rebroadcasts this stream.

I then point [ffmpeg](https://www.ffmpeg.org/) at the nginx stream and it extracts the images into a folder named after the speaker; all this is done through a simple [Makefile](./Makefile).

The last component is the networking. I need the the iPhone to stream nicely to my laptop, and I don't want to rely on the venue wifi, and I can't use mobile data, because the rtmp stream needs to connect to my laptop, so instead I've got a [Netgear N300 wifi range extender](https://www.amazon.co.uk/NETGEAR-Extender-External-Antennas-EX2700-100UKS/dp/B00NIUHAG6/ref=pd_lpo_vtph_147_bs_lp_tr_t_1?_encoding=UTF8&psc=1&refRID=8JRBPGWVJG39BS27H2JC) which both my laptop and the iPhone 4 connect to.

I can configure the Netgear to use the venue wifi or use another phone's hotspot for the actual internet connection.
