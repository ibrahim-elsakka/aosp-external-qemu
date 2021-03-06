/* Copyright (C) 2007 The Android Open Source Project
**
** This software is licensed under the terms of the GNU General Public
** License version 2, as published by the Free Software Foundation, and
** may be copied, distributed, and modified under those terms.
**
** This program is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
*/

#pragma once

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "android/emulation/control/battery_agent.h"
#include "android/emulation/control/cellular_agent.h"
#include "android/emulation/control/finger_agent.h"
#include "android/emulation/control/location_agent.h"
#include "android/emulation/control/net_agent.h"
#include "android/emulation/control/sensors_agent.h"
#include "android/emulation/control/telephony_agent.h"
#include "android/emulation/control/user_event_agent.h"
#include "android/emulation/control/vm_operations.h"
#include "android/skin/rect.h"
#include "android/utils/compiler.h"

ANDROID_BEGIN_HEADER

/** in vl.c */

/* emulated network up/down speeds, expressed in bits/seconds */
extern double   qemu_net_upload_speed;
extern double   qemu_net_download_speed;

/* emulated network min-max latency, expressed in ms */
extern int      qemu_net_min_latency;
extern int      qemu_net_max_latency;

/* global flag, when true, network is disabled */
extern int      qemu_net_disable;

/* list of supported network speed names and values in bits/seconds */
typedef struct {
    const char*  name;
    const char*  display;
    int          upload;
    int          download;
} NetworkSpeed;

extern const NetworkSpeed   android_netspeeds[];
extern const size_t android_netspeeds_count;

/* list of supported network latency names and min-max values in ms */
typedef struct {
    const char*  name;
    const char*  display;
    int          min_ms;
    int          max_ms;
} NetworkLatency;

extern const NetworkLatency  android_netdelays[];
extern const size_t android_netdelays_count;

/* default network settings for emulator */
#define  DEFAULT_NETSPEED  "full"
#define  DEFAULT_NETDELAY  "none"

/* enable/disable interrupt polling mode. the emulator will always use 100%
 * of host CPU time, but will get high-quality time measurments. this is
 * required for the tracing mode unless you can bear 10ms granularities
 */
extern void  qemu_polling_enable(void);
extern void  qemu_polling_disable(void);

/**in hw/android/goldfish/fb.c */

/* framebuffer dimensions in pixels, note these can change dynamically */
extern int  android_framebuffer_w;
extern int  android_framebuffer_h;
/* framebuffer dimensions in mm */
extern int  android_framebuffer_phys_w;
extern int  android_framebuffer_phys_h;

/* framebuffer rotation, relative to device */
extern SkinRotation  android_framebuffer_rotation;

/**  in android_main.c */

/* this is the port used for the control console in this emulator instance.
 * starts at 5554, with increments of 2 */
extern int   android_base_port;

/* parses a network speed parameter and sets qemu_net_upload_speed and
 * qemu_net_download_speed accordingly. returns -1 on failure, 0 on success */
extern int   android_parse_network_speed(const char*  speed);

/* parse a network delay parameter and sets qemu_net_min/max_latency
 * accordingly. returns -1 on error, 0 on success */
extern int   android_parse_network_latency(const char*  delay);

/**  in qemu_setup.c */

extern void android_emulation_setup(
        const QAndroidBatteryAgent* batteryAgent,
        const QAndroidCellularAgent* cellularAgent,
        const QAndroidFingerAgent* fingerAgent,
        const QAndroidLocationAgent* locationAgent,
        const QAndroidSensorsAgent* sensorsAgent,
        const QAndroidTelephonyAgent* telephonyAgent,
        const QAndroidUserEventAgent* userEventAgent,
        const QAndroidVmOperations* vmOperations,
        const QAndroidNetAgent* netAgent);
extern void  android_emulation_teardown( void );

ANDROID_END_HEADER
