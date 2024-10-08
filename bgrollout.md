```yaml
# Blue Service
---
apiVersion: v1
kind: Service
metadata:
  name: {{ .Values.labels }}-service-active-blue
spec:
  type: {{ .Values.service.type }}
  selector:
    app: {{ .Values.labels }}
  ports:
    - port: {{ .Values.service.port }}
      targetPort: {{ .Values.service.targetPort }}
      nodePort: {{ .Values.service.nodePortBlue }}

# Green Service
---
apiVersion: v1
kind: Service
metadata:
  name: {{ .Values.labels }}-service-preview-green
spec:
  type: {{ .Values.service.type }}
  selector:
    app: {{ .Values.labels }}
  ports:
    - port: {{ .Values.service.port }}
      targetPort: {{ .Values.service.targetPort }}
      nodePort: {{ .Values.service.nodePortGreen }}

# Rollout
---
apiVersion: argoproj.io/v1alpha1
kind: Rollout
metadata:
  name: {{ .Values.labels }}-rollout
spec:
  replicas: {{ .Values.replicaCount }}
  revisionHistoryLimit: {{ .Values.revisionHistoryLimit }}
  selector:
    matchLabels:
      app: {{ .Values.labels }}
  template:
    metadata:
      labels:
        app: {{ .Values.labels }}
    spec:
      containers:
      - name: {{ .Values.containerName }}
        image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
        imagePullPolicy: {{ .Values.image.imagePullPolicy }}
        ports:
        - containerPort: {{ .Values.service.port }}

      {{- with .Values.imagePullSecrets }}
      imagePullSecrets:
        {{- toYaml . | nindent 8 }}
      {{- end }}

  strategy:
    blueGreen:
      activeService: {{ .Values.labels }}-service-active-blue
      previewService: {{ .Values.labels }}-service-preview-green
      autoPromotionEnabled: true
```