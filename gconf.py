import sys
import os

project = sys.argv[1]
N = int(sys.argv[2])
out = sys.argv[3]

cf = lambda id, bp: f"""version: 1
build:
  proto:
    path: proto
    third_party_paths:
    - third_party/proto
    - proto_vendor
accounts:
- name: alice
  coins:
  - 1000token
  - 1000000000stake
- name: bob
  coins:
  - 500token
  - 100000000stake
faucet:
  name: bob
  coins:
  - 5token
  - 100000stake
  host: :{bp+6}
genesis:
  chain_id: {project}-{id:02d}
validators:
- name: alice
  bonded: 100000000stake
  app:
    api:
      address: :{bp}
    grpc:
      address: :{bp+1}
    grpc-web:
      address: :{bp+2}
  config:
    p2p:
      laddr: :{bp+3}
    rpc:
      laddr: :{bp+4}
      pprof_laddr: :{bp+5}
  home: $HOME/.{project}-{id:02d}
"""

os.makedirs(out, exist_ok=True)
available_port = 10001
for i in range(N):
    with open(f"{out}/{project}-{i:02d}.yml", "w") as f:
        f.write(cf(i, available_port))
        available_port += 7
