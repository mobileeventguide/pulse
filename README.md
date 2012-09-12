pulse
=====

utility class to invoke selector on instance at intervals and prevent NSTimer retain cycles


Usage
-----
Start the pulse

    [Pulse pulse:self every:1 withSelector:@selector(updateNetworkIndicator)];

Stop the pulse

    [Pulse stopPulsing:self]; 
