# deploy-svc-probes

This chart is a Helm-ified version of deploy-svc-probes-resources.yaml and included configmaps:

- `deploy-svc-probes-resources.yaml` (Service + Deployment)
- `cm-deploy-svc-probes.yaml` (ConfigMap `ext-checker-config`)
- `cm-httpd-conf.yaml` (ConfigMap `cm-httpd-conf` containing `httpd.conf`)

## Install

```bash
helm install my-release ./deploy-svc-probes -n my-namespace --create-namespace
```

## Keep the original resource names

To recreate the original names from your YAMLs (`httpd-dep-1`, `ext-checker-config`, `cm-httpd-conf`):

```bash
helm install httpd-dep-1 ./deploy-svc-probes -n default \
  --set fullnameOverride=httpd-dep-1 \
  --set extChecker.configMapName=ext-checker-config \
  --set httpd.configMapName=cm-httpd-conf
```

## Notes

- The `cm-httpd-conf` content is stored as `files/httpd.conf` and injected into the ConfigMap using Helm's file access functions.
- `spec.trafficDistribution` is optional in the Service template and is omitted by default.
