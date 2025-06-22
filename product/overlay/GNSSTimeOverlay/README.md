# GNSSTimeOverlay

Enable GNSS time detection for Android 12+

## Q&A

Q: Why is it necessary?

A: The AOSP default clock source is prioritized from the NTP server, while the Carrier Network Time is used as a secondary source. GNSS is supported as a clock source starting with Android 12, but is not enabled by default.
Installing this module is recommended if you care about time accuracy and your location is not connected to AOSP's default NTP server.

AOSP's default NTP server is `time.android.com`; the `android.com` domain is not reachable in some regions and thus cannot synchronize the time. If the NTP time cannot be synchronized and the time cannot be obtained from the carrier's network (For example, using a cell phone without inserting a SIM card), the device's clock will be incorrect.

To change the default NTP server (If a SIM card is inserted, this is not necessary, as the system will automatically change to an accessible server.)

```bash
adb shell settings put global ntp_server pool.ntp.org
```

Q: How do I verify that the GNSS clock source is enabled?

Check the result of the command

```bash
adb shell cmd time_detector dump
```

The GNSS time source is enabled if the result is as follows:

```text
TimeDetectorStrategy:
mCurrentConfigurationInternal=ConfigurationInternal{...mOriginPriorities=[network,telephony,gnss]...}...
.
.
.
Gnss suggestion history:
....
```

GNSS time synchronization history can be viewed from `Gnss suggestion history`

Q: When gnss time update service suggests a GNSS time?

A: GNSS time will be passively updated when another app or service in the system requests location updates.

Q: How to force update NTP time?

```bash
adb shell cmd network_time_update_service force_refresh
```

## Troubleshoot

In some head units, the continuous clock of the device stops when it enters sleep mode after the engine is turned off. This causes the GNSS time source of the time detector service to stop timing. When the engine is restarted to wake up the head unit, this causes a time delay. Therefore, it is not recommended to enable this feature in head units with poor sleep mode implementation (Then I found that 7870-DUDUAUTO was one of them.).
