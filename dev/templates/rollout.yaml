---
apiVersion: v1
kind: Service
metadata:
  name: {{ .Values.labels }}-service
spec:
  type: {{ .Values.service.type }}
  selector:
    app: {{ .Values.labels }}
  ports:
    - port: {{ .Values.service.port }}       # target port and port value are set to same 
      targetPort: {{.Values.service.targetPort}} #port on which application is running
      nodePort: {{.Values.service.nodePort}}
---
apiVersion: v1
kind: Service
metadata:
  name: {{ .Values.labels }}-canary-service
spec:
  type: {{ .Values.service.type }}
  selector:
    app: {{ .Values.labels }}
  ports:
    - port: {{ .Values.service.port }}      
      targetPort: {{.Values.service.targetPort}} 
      nodePort: {{.Values.service.nodePortCanary}}


# Rollout
---
apiVersion: argoproj.io/v1alpha1
kind: Rollout
metadata:
  name: {{ .Values.labels }}-rollout-canary
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
    canary:
      maxSurge: "50%"
      maxUnavailable: 0
      steps:
      - setWeight: 10
      - pause:
          duration: 10m
      - setWeight: 20
      - pause: {}
      canaryService: {{ .Values.labels }}-canary-service
      stableService: {{ .Values.labels }}-service

