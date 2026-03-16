#!/usr/bin/env python3

import time

import xrobotoolkit_sdk as xrt


def on_frame(snapshot):
    body = snapshot["body"]
    print(
        "timestamp_ns=",
        snapshot["timestamp_ns"],
        "body_available=",
        body["available"],
        "headset_pose=",
        snapshot["headset_pose"],
    )


def main():
    xrt.init()
    xrt.register_frame_callback(on_frame)
    print("Frame callback registered. Waiting for XR updates. Press Ctrl+C to stop.")

    try:
        while True:
            time.sleep(1.0)
    except KeyboardInterrupt:
        pass
    finally:
        xrt.clear_frame_callback()
        xrt.close()


if __name__ == "__main__":
    main()
