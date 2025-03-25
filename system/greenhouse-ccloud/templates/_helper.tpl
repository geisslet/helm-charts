{{/* Get related Thanos store endpoints */}}
{{- define "getRelatedStoreEndpoints" -}}
{{- $name := index . 0 -}}
{{- $root := index . 1 -}}
{{- $stores := list }}
{{- range $plugin := $root.Values.ingressPlugins -}}
{{- $thanosStore := printf "thanos-grpc.%s:443" (trimSuffix "." (trimPrefix "ingress." $plugin.recordName)) -}}
{{- if contains $name $thanosStore -}}
{{- $stores = append $stores $thanosStore -}}
{{- end -}}
{{- end -}}
{{ range $k, $v := $stores }}
  - {{ $v }}
{{- end }}
{{- end -}}

{{/* Get related Thanos store endpoints */}}
{{- define "thanosStoreEndpoints" -}}
{{- range $cluster := .Values.thanos.globalClusters -}}
{{- $stores := (include "getRelatedStoreEndpoints" (list $cluster.prefix $)) }}
{{- if $stores }}
- clusterName: {{ $cluster.name }}
  overrides:
  - name: thanos.query.stores
    value: 
      {{- $stores | nindent 8 }}
{{- end }}
{{- end }}
{{- end }}
