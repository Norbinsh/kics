package Cx

CxPolicy [ result ] {
    document := input.document[i]
    
    isTiller(document)

    result := isAccessible(document)
}

CxPolicy [ result ] {
    document := input.document[i]
    
    isTillerTemplate(document)

    result := isAccessibleTemplate(document)
}
############################################################
isTiller(document) {
    document.spec.containers
    checkMetadata(document.metadata)
}

isTillerTemplate(document) {
    document.spec.template.spec.containers
    checkMetadata(document.spec.template.metadata)
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
##############################################################
isAccessible(document) = result {
    container := document.spec.containers[j]
    result:= evalContainer(container,j,"")
}

isAccessibleTemplate(document) = result {
    container := document.spec.template.spec.containers[j]
    result:= evalTemplateContainer(container,j)
}

evalContainer(container,idx,prefix) = result {
    contains(container.image,"tiller")

    object.get(container,"args","undefined") == "undefined"
    result := {
                "documentId": 		input.document[i].id,
                "searchKey": 	    sprintf("%sspec.containers",[prefix]),
                "issueType":		"MissingAttribute",
                "keyExpectedValue":  sprintf("'%sspec.containers[%d].args' is set", [prefix,idx]),
                "keyActualValue": 	sprintf("'%sspec.containers[%d].args' is undefined", [prefix,idx])
              }
}

evalContainer(container,idx,prefix) = result {
    contains(container.image,"tiller")

    not listenLocal(container.args)
    
    result := {
                "documentId": 		input.document[i].id,
                "searchKey": 	    sprintf("%sspec.containers.args",[prefix]),
                "issueType":		"IncorrectValue",
                "keyExpectedValue":  sprintf("'%sspec.containers[%d].args' set the container to listen to localhost", [prefix,idx]),
                "keyActualValue": 	sprintf("'%sspec.containers[%d].args' is not setting the container to lister to localhost", [prefix,idx])
              }
}

evalTemplateContainer(container,idx) = result {
    result:= evalContainer(container,idx,"spec.template.")
}

listenLocal(args) {
    some j
        arg := args[j]
        is_string(arg)
        contains(arg,"--listen")
        localAddress(arg)
}

localAddress(arg) {
    contains(arg,"localhost")
}

localAddress(arg) {
    contains(arg,"127.0.0.1")
}

