{{- define "twenty.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "twenty.name" -}}
{{- .Chart.Name -}}
{{- end -}}

{{- define "twenty.labels" -}}
helm.sh/chart: {{ include "twenty.name" . }}-{{ .Chart.Version | replace "+" "_" }}
{{ include "twenty.selectorLabels" . }}
{{- end -}}

{{- define "twenty.selectorLabels" -}}
app.kubernetes.io/name: {{ include "twenty.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
