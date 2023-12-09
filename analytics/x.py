import psutil
import time
import json

f = open("process.log", "a")
counter = 0
FLUSH = 50

while True:
    for p in psutil.process_iter(['pid', 'name', 'cmdline']):
        d = p.info
        if d["name"] == "frostd" or d["name"] == "ignite":
            with p.oneshot():
                snap = {
                    "now": time.time_ns(),
                    "name": d["name"],
                    "cmd": p.cmdline(),
                    "cpu-%": p.cpu_percent(),
                    "cpu-times": p.cpu_times()._asdict(),
                    "io-counters": p.io_counters()._asdict(),
                    "mem-full": p.memory_full_info()._asdict(),
                    "mem-%": p.memory_percent(),
                }
                r = json.dumps(snap) + "\n"
                f.write(r)
                if counter % FLUSH:
                    f.flush()
    time.sleep(0.1)
    counter += 1