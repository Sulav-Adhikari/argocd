```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Values.labels }}-deployment
  labels:
    app: {{ .Values.labels }}
spec:
  replicas: {{.Values.replicaCount }}
  selector:
    matchLabels:
      app: {{ .Values.labels }}
  template:
    metadata:
      labels:
        app: {{.Values.labels }}
    spec:
      containers:
      - name: {{.Values.containerName }}
        image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
        ports:
        - containerPort: {{ .Values.service.port }}

      {{- with .Values.imagePullSecrets }}
      imagePullSecrets:
        {{- toYaml . | nindent 8 }}
      {{- end }}

#Blue Service
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
    - port: {{ .Values.service.port }}       # target port and port value are set to same 
      targetPort: {{.Values.service.targetPort}} #port on which application is running
      nodePort: {{.Values.service.nodePort}}

#Green Service
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
    - port: {{ .Values.service.port }}       # target port and port value are set to same 
      targetPort: {{.Values.service.targetPort}} #port on which application is running
      nodePort: {{.Values.service.nodePort}}
```