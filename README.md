# CIDR allocation
The CIDR range reserved for the fire-calculator application is `11.16.0.0/16` ~ `11.63.0.0/16`.
In each AZ, 2 `/16` VPCs are reserved. This totals 48 VPCs across 4 AWS accounts.

| Account | Region | AZs | CIDR |
| -------- | -------- | -------- | -------- |
| Dev | ap-southeast-2 | a | 11.16.0.0/16 11.17.0.0/16|
| ~ | ~ | b | 11.18.0.0/16 11.19.0.0/16|
| ~ | ~ | c | 11.20.0.0/16 11.21.0.0/16|
| ~ | ap-southeast-4 | a | 11.22.0./16 11.23.0.0/16|
| ~ | ~ | b | 11.24.0.0/16 11.25.0.0/16|
| ~ | ~ | c | 11.26.0.0/16 11.27.0.0/16|