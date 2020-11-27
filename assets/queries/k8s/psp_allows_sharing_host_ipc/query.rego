package Cx

CxPolicy [ result ] {
    document := input.document[i]
    document.kind == "PodSecurityPolicy"

    document.spec.hostIPC == true

	result := {
                "documentId": 		input.document[i].id,
                "searchKey": 	    "spec.hostIPC",
                "issueType":		"IncorrectValue",
                "keyExpectedValue": "'spec.hostIPC' is false or undefined",
                "keyActualValue": 	"'spec.hostIPC' is true"
              }
} 