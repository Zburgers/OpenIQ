# External Resources

This directory defines how OpenIQ consumes upstream research software, data, and test resources.

## Policy

`external/vendor/`, `external/downloads/`, and `external/restricted/` are gitignored. Upstream resources are fetched locally from the URLs/commits recorded in `external/sources.lock.yml` and `resources/SOURCES.md`.

Why not blindly vendor everything?

- a paper being open-access does not automatically permit redistribution of all associated stimuli;
- software, stimuli, data, scoring keys, and documentation may have different licenses;
- some cognitive tests depend on item security to preserve validity;
- large datasets do not belong in ordinary Git history;
- pinned upstream versions make replication easier than copying untraceable folders.

## Directory convention

```text
external/
  vendor/       # cloned/open upstream code (local only by default)
  downloads/    # archives/data pulled from OSF/Figshare/etc. (local only)
  restricted/   # approved but non-public test materials (never commit)
  sources.lock.yml
```

Before moving any third-party file into tracked repository paths, update the resource registry with explicit redistribution permission and required attribution.
