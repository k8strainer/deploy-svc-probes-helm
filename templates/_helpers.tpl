{{/*
Common template helpers.
*/}}

{{- define "deploy-svc-probes.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "deploy-svc-probes.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := include "deploy-svc-probes.name" . -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "deploy-svc-probes.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" -}}
{{- end -}}

{{- define "deploy-svc-probes.commonLabels" -}}
helm.sh/chart: {{ include "deploy-svc-probes.chart" . }}
app.kubernetes.io/name: {{ include "deploy-svc-probes.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.labels }}
tier: {{ .tier | quote }}
track: {{ .track | quote }}
{{- end }}
{{- end -}}

{{- define "deploy-svc-probes.selectorLabels" -}}
app.kubernetes.io/name: {{ include "deploy-svc-probes.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- with .Values.labels }}
tier: {{ .tier | quote }}
track: {{ .track | quote }}
{{- end }}
{{- end -}}

{{- define "deploy-svc-probes.extCheckerConfigMapName" -}}
{{- if .Values.extChecker.configMapName -}}
{{- .Values.extChecker.configMapName -}}
{{- else -}}
{{- printf "%s-ext-checker-config" (include "deploy-svc-probes.fullname" .) -}}
{{- end -}}
{{- end -}}

{{- define "deploy-svc-probes.httpdConfConfigMapName" -}}
{{- if .Values.httpd.configMapName -}}
{{- .Values.httpd.configMapName -}}
{{- else -}}
{{- printf "%s-cm-httpd-conf" (include "deploy-svc-probes.fullname" .) -}}
{{- end -}}
{{- end -}}
