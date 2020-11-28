package Cx

CxPolicy [ result ] {
    document := input.document[i]
    object.get(document,"kind","undefined") == "PodSecurityPolicy"

    object.get(document.spec,"hostNetwork","undefined") == true

	result := {
                "documentId": 		input.document[i].id,
                "searchKey": 	    "spec.hostNetwork",
                "issueType":		"IncorrectValue",
                "keyExpectedValue": "'spec.hostNetwork' is false or undefined",
                "keyActualValue": 	"'spec.hostNetwork' is true"
              }
}