# Research Resource Registry

This directory is the authoritative index for external scientific resources used by OpenIQ.

- `SOURCES.md` — human-readable source registry with purpose, citation, access, license/security notes, and integration decision.
- `registry.yml` — machine-readable source inventory.
- `../external/sources.lock.yml` — pinned Git repositories/resources for reproducible local acquisition.

## Rule

A resource is not “ours” because it is public. Before committing any third-party material, determine separately:

1. **access** — can we download/use it?
2. **redistribution** — can we republish it in OpenIQ?
3. **derivatives** — can we modify it?
4. **test security** — would public exposure undermine validity or violate provider guidance?
5. **citation/attribution** — what must accompany use?

When uncertain, keep only metadata/links in Git and acquire the resource locally.
