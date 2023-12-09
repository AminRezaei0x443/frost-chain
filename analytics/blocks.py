import requests
import json
from tqdm import tqdm 

blocks = range(1, 3000)
servers = list(map(lambda i: 10001 + i * 7, range(5)))
print("target servers:", servers)

for i, s in enumerate(servers):
    collected = []

    for b in tqdm(blocks):
        u = f"http://0.0.0.0:{s}/cosmos/tx/v1beta1/txs/block/{b}"
        o = requests.get(u)
        j = json.loads(o.content)
        collected.append(j)

    with open(f"blocks-{i}.json", "w") as f:
        json.dump(collected, f)
