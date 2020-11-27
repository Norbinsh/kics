package Cx

CxPolicy [ result ] {
    document := input.document[i]
    document.kind == "PodSecurityPolicy"
    
    document.spec.hostPID == true

	result := {
                "documentId": 		input.document[i].id,
                "searchKey": 	    "spec.hostPID",
                "issueType":		"IncorrectValue",
                "keyExpectedValue": "'spec.hostPID' is false or undefined",
                "keyActualValue": 	"'spec.hostPID' is true"
              }
}