# GPU & CPU Tweak MediaTek Dimensity 700 (MT6833) Dimensity 720 (MT6853) Dimensity 800 (MT6873) Dimensity 800U (MT6877)

A kernel-level performance script for rooted Android devices (Magisk), targeting Mali GPU, the Linux CFS scheduler, and MediaTek low-power subsystems. Runs automatically after boot and applies tweaks that reduce latency, improve frame pacing, and prevent the CPU from throttling itself at the wrong time.

---

## What this module optimizes

### GPU (Mali)
Forces the GPU to stay powered on at all times (`always_on` power policy), eliminating the latency spike that occurs when the GPU wakes from idle mid-frame. Job scheduling is set to context-aware mode so workloads are distributed more fairly across shader cores. The DVFS and job scheduling periods are both tightened to 25 ms for more responsive frequency adjustments. Soft job timeout is raised to 5000 ms and reset timeout to 3000 ms to prevent the driver from prematurely aborting long GPU workloads. Memory pool limits are set generously (32768 pages per pool across all 16 slots) to reduce allocation overhead during heavy rendering, while low-priority pool limits are kept conservative (64 pages) to avoid wasting memory on background tasks. Job serialization is disabled so the GPU can process multiple jobs in parallel.

### CPU scheduler (CFS)
Disables child-first scheduling so newly spawned threads don't preempt their parent, reducing context switch noise. Energy-aware and C-state-aware scheduling are both turned off — useful on gaming or performance workloads where the kernel's power-saving heuristics cause more jank than they save. Scheduler latency is set to 8 ms with a minimum granularity of 1 ms, striking a balance between throughput and responsiveness. Wakeup granularity is set to 1.5 ms to prevent newly woken threads from immediately preempting a running one. Migration cost is set to 50 µs to discourage excessive cross-core task bouncing. The RT scheduler gets 95% of each 1-second period (`sched_rt_runtime_us 950000`), giving real-time threads like audio and input nearly full priority. Sync hints are enabled so the scheduler respects inter-thread synchronization signals. Utility clamping is configured with a minimum of 64 and a maximum of 1024, preventing the scheduler from starving threads that need consistent CPU frequency. Task migration batch size is set to 32 for smoother load balancing under multi-threaded workloads.

### Low power mode (MediaTek)
Disables three MediaTek-specific low-power residency (RC) features: DRAM self-refresh gating, system PLL shutdown, and bus clock (26 MHz) gating. These are idle-state power optimizations that can introduce unpredictable re-entry latency when the system wakes from a brief idle period. Disabling them keeps clocks and memory active, trading a small amount of idle power for more consistent wakeup latency — particularly beneficial during gaming or any sustained interactive session.

---

## Compatibility

- Device with MediaTek processor and Mali GPU
- Android 10.0 or higher
- Kernel version 4.14 or higher
- Magisk 26 or higher
- MediaTek SoC (Mali GPU + MTK low-power subsystem)

## Download

- Download from the [release page](https://github.com/sanndyrmdhn/Tweak_MediaTek_G57/releases)
- Download and flash the zip in magisk manager ( Not tested in KSU and APatch )
- Reboot the device

## Notes
- The Mali GPU path (`13000000.mali`) is specific to certain MediaTek platforms — verify the path on your device before flashing
- Disabling MTK low-power features will slightly increase idle power consumption; this module is optimized for performance, not battery life
