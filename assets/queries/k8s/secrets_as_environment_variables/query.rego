package Cx

CxPolicy [ result ] {
    document := input.document[i]
    document.kind == "Pod"
    
    containers := ["containers", "initContainers"]
    
    document.spec[containers[c]][j].env[k].valueFrom.secretKeyRef
    
    container_name := document.spec[containers[c]][j].name
    env_name := document.spec[containers[c]][j].env[k].name

	result := {
                "documentId": 		input.document[i].id,
                "searchKey": 	    sprintf("spec.%s", [containers[c]]),
                "issueType":		"IncorrectValue",
                "keyExpectedValue": sprintf("'%s[%s].env[%s].valueFrom.secretKeyRef' is undefined", [containers[c], container_name, env_name]),
                "keyActualValue": 	sprintf("'%s[%s].env[%s].valueFrom.secretKeyRef' is defined", [containers[c], container_name, env_name]),
              }
}

CxPolicy [ result ] {
    document := input.document[i]
    document.kind == "Pod"
    
    containers := ["containers", "initContainers"]
    
    document.spec[containers[c]][j].envFrom[k].secretRef
    
    container_name := document.spec[containers[c]][j].name

	result := {
                "documentId": 		input.document[i].id,
                "searchKey": 	    sprintf("spec.%s", [containers[c]]),
                "issueType":		"IncorrectValue",
                "keyExpectedValue": sprintf("'%s[%s].envFrom.secretRef' is undefined", [containers[c], container_name]),
                "keyActualValue": 	sprintf("'%s[%s].envFrom.secretRef' is defined", [containers[c], container_name])
              }
}