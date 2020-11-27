package Cx

CxPolicy [ result ] {
    document := input.document[i]
    keyword := "tiller"

    metadata := document.metadata
    contains(metadata.name,keyword)

	result := {
                "documentId": 		input.document[i].id,
                "searchKey": 	    "metadata.name",
                "issueType":		"IncorrectValue",
                "keyExpectedValue": "metadata.name does not contain 'tiller'",
                "keyActualValue":  "document[%d].metadata.name contains 'tiller'"
              }
}

CxPolicy [ result ] {
    document := input.document[i]
    keyword := "tiller"

    metadata := document.metadata
    labels:= metadata.labels
    some j
        contains(labels[j],keyword)
    
	result := {
                "documentId": 		input.document[i].id,
                "searchKey": 	    sprintf("metadata.labels.%s", [j]),
                "issueType":		"IncorrectValue",
                "keyExpectedValue": "metadata.labels does not have values that contain 'tiller'",
                "keyActualValue": 	sprintf("metadata.labels.%s contains 'tiller'", [j])
              }
}

CxPolicy [ result ] {
    document := input.document[i]
    keyword := "tiller"

    selector := document.spec.selector

    some j
        contains(selector[j],keyword)


	result := {
                "documentId": 		input.document[i].id,
                "searchKey": 	    sprintf("spec.selector.%s", [j]),
                "issueType":		"IncorrectValue",
                "keyExpectedValue": "spec.selector does not have values that contain 'tiller'",
                "keyActualValue": 	sprintf("spec.selector.%s contains 'tiller'", [j])
              }
}