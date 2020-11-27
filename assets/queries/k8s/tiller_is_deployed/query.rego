package Cx

CxPolicy [ result ] {
    document := input.document[i]
    
    checkMetadata(document.metadata)

    result := {
                "documentId": 		input.document[i].id,
                "searchKey": 	    "metadata",
                "issueType":		"IncorrectValue",
                "keyExpectedValue":  "'metadata' does not refer any Tiller resource",
                "keyActualValue": 	"'metadata' refer to a Tiller resource"
              }
}

CxPolicy [ result ] {
    document := input.document[i]
    
    some j
        contains(object.get(document.spec.containers[j],"image","undefined"), "tiller")
    
    result := {
                "documentId": 		input.document[i].id,
                "searchKey": 	    "spec.containers",
                "issueType":		"IncorrectValue",
                "keyExpectedValue":  "'spec.containers' don't have any Tiller containers",
                "keyActualValue": 	"'spec.containers' contains a Tiller container"
              }
}

CxPolicy [ result ] {
    document := input.document[i]
    
    checkMetadata(document.spec.template.metadata)

    result := {
                "documentId": 		input.document[i].id,
                "searchKey": 	    "spec.template.metadata",
                "issueType":		"IncorrectValue",
                "keyExpectedValue":  "'spec.template.metadata' does not refer any Tiller resource",
                "keyActualValue": 	"'spec.template.metadata' refer to a Tiller resource"
              }
}

CxPolicy [ result ] {
    document := input.document[i]
    
    some j
        contains(object.get(document.spec.template.spec.containers[j],"image","undefined"), "tiller")

    result := {
                "documentId": 		input.document[i].id,
                "searchKey": 	    "spec.template.spec.containers",
                "issueType":		"IncorrectValue",
                "keyExpectedValue":  "'spec.template.spec.containers' don't have any Tiller containers",
                "keyActualValue": 	"'spec.template.spec.containers' contains a Tiller container"
              }
}

checkMetadata(metadata) {
    contains(metadata.name,"tiller")
}

checkMetadata(metadata) {
    object.get(metadata.labels,"app","undefined") == "helm"
}

checkMetadata(metadata) {
    contains(object.get(metadata.labels,"name","undefined"),"tiller")
}