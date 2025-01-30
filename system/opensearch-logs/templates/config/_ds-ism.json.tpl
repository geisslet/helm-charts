{
    "policy": {
        "policy_id": "otel-_DS_NAME_-ism",
        "description": "Datastream (ds) ism policy for _DS_NAME_-ds",
        "schema_version": _SCHEMAVERSION_,
        "default_state": "initial",
        "states": [
            {
                "name": "initial",
                "actions": [],
                "transitions": [
                    {
                        "state_name": "rollover",
                        "conditions": {
                            "min_index_age": "7d"
                        }
                    },
                    {
                        "state_name": "rollover",
                        "conditions": {
                            "min_size": "30gb"
                        },
                    {
                        "state_name": "rollover",
                        "conditions": {
                            "max_docs": "50000000"
                        },

                    }
                ]
            },
            {
                "name": "rollover",
                "actions": [
                    {
                        "retry": {
                            "count": 5,
                            "backoff": "exponential",
                            "delay": "1m"
                        },
                        "rollover": {
                            "min_doc_count": 5,
                            "min_index_age": "1d",
                            "copy_alias": false
                        }
                    }
                ],
                "transitions": [
                    {
                        "state_name": "delete",
                        "conditions": {
                            "min_index_age": "{{ .Values.retention.ds }}"
                        }
                    }
                ]
            },
            {
                "name": "delete",
                "actions": [
                    {
                        "retry": {
                            "count": 3,
                            "backoff": "exponential",
                            "delay": "1m"
                        },
                        "delete": {}
                    }
                ],
                "transitions": []
            }
        ],
        "ism_template":
            {
                "index_patterns": [
                    "_DS_NAME_-datastream"
                ],
                "priority": 1
            }
    }
}
