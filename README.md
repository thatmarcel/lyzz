# Lyzz
**Music visualizer (Spiritual successor / simpler rewrite of Mitsuha Forever)**

After ConorTheDev stopped maintaining Mitsuha Forever,
I decided I wanted to rewrite Mitsuha Forever to be easier
to maintain and more stable.

I am currently not sure if I will release
Lyzz because [Ryan Nair](https://github.com/ryannair05) is
maintaining a fork of the original Mitsuha Forever.

## Features

Currently, Lyzz supports the following things (changable via tweak settings):

**Apps**
- Lockscreen Music Notification
- Spotify
- Apple Music

**Color modes**
- Custom Color
- ColorFlow 5

**Visualizer styles**
- Bars
- Waves

### Developer instructions
You can use the normal commands like make package etc. when you have THEOS installed.

To successfully build, clone https://github.com/cbyrne/libappearancecell
and run 'make' to put the necessary files for libappearancecell
on your system.

You also need to have the iOS 11.2 SDK in /opt/theos/sdks/iPhoneOS11.2.sdk
or change the SDK location in Prefs/Makefile

To debug the application, go into Logging/LyzzLogging.m and set LOGGING_ENABLED to true
and LOGGING_HOST_IP to the local ip address of your computer. Then, go into LoggingDesktopServer,
run npm install and npm start. You will then see all logs appear on your computer.
