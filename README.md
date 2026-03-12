# deploy-svc-probes

Helm chart for deploying an Apache httpd Deployment, Service, and two ConfigMaps:

- `deploy-svc-probes-resources.yaml` (Service + Deployment)
- `cm-deploy-svc-probes.yaml` (ConfigMap `ext-checker-config`)
- `cm-httpd-conf.yaml` (ConfigMap `cm-httpd-conf` containing `httpd.conf`)

## Prerequisites

- Kubernetes or OpenShift cluster
- Helm 3.x
- Access to the target namespace
- Container images reachable from the cluster


## Install from GitHub

Clone the repository and install the chart from the local directory:

```bash
git clone https://github.com/k8strainer/deploy-svc-probes-helm.git
cd deploy-svc-probes-helm
helm install my-release . -n my-namespace --create-namespace

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
