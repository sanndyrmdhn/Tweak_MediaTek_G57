while [[ "$(getprop sys.boot_completed)" != "1" ]]; do
    sleep 3
done
# Tweak GPU
echo always_on > /sys/devices/platform/13000000.mali/power_policy
echo 1 > /sys/devices/platform/13000000.mali/js_ctx_scheduling_mode
echo 25 > /sys/devices/platform/13000000.mali/dvfs_period
echo 25 > /sys/devices/platform/13000000.mali/js_scheduling_period
echo 5000 > /sys/devices/platform/13000000.mali/soft_job_timeout
echo 3000 > /sys/devices/platform/13000000.mali/reset_timeout
echo 32768 32768 32768 32768 32768 32768 32768 32768 32768 32768 32768 32768 32768 32768 32768 32768 > /sys/devices/platform/13000000.mali/mem_pool_max_size
echo 64 64 64 64 64 64 64 64 64 64 64 64 64 64 64 64 > /sys/devices/platform/13000000.mali/lp_mem_pool_max_size
echo none > /sys/devices/platform/13000000.mali/scheduling/serialize_jobs

# Tweak CPU
echo 0 > /proc/sys/kernel/sched_child_runs_first
echo 0 > /proc/sys/kernel/sched_energy_aware
echo 0 > /proc/sys/kernel/sched_cstate_aware
echo 8000000 > /proc/sys/kernel/sched_latency_ns
echo 1000000 > /proc/sys/kernel/sched_min_granularity_ns
echo 1500000 > /proc/sys/kernel/sched_wakeup_granularity_ns
echo 50000 > /proc/sys/kernel/sched_migration_cost_ns
echo 1000000 > /proc/sys/kernel/sched_rt_period_us
echo 950000 > /proc/sys/kernel/sched_rt_runtime_us
echo 1 > /proc/sys/kernel/sched_sync_hint_enable
echo 64 > /proc/sys/kernel/sched_util_clamp_min
echo 1024 > /proc/sys/kernel/sched_util_clamp_max
echo 32 > /proc/sys/kernel/sched_nr_migrate

#Tweak Low Power Mode
echo 0 > /proc/mtk_lpm/lpm/rc/dram/enable
echo 0 > /proc/mtk_lpm/lpm/rc/syspll/enable
echo 0 > /proc/mtk_lpm/lpm/rc/bus26m/enable