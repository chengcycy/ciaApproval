//var server = 'http://10.11.26.187:11014'
var server = 'http://210.14.152.181:8400'


function getContactsJSONFile(callback) {
    var interfacePath = '/Approval/ApprovalController/getJSONFile.do?jsonFile=contacts.json'

    var httpRequest = new XMLHttpRequest()
    httpRequest.onreadystatechange = function() {
        if (httpRequest.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            console.log("Headers -->");
            console.log(httpRequest.getAllResponseHeaders ());
            console.log("Last modified -->");
            console.log(httpRequest.getResponseHeader ("Last-Modified"));
        } else if (httpRequest.readyState === XMLHttpRequest.DONE) {
            console.log('getContactsJSONFile response:' + httpRequest.responseText);
            if (callback) {
                callback(httpRequest.responseText)
            }
        }
    }
    httpRequest.onerror = function() {
        console.log('error')
    }

    var url = server + interfacePath
    url = encodeURI(url)
    httpRequest.open('POST', url)
    httpRequest.send()

    console.log(url)
}

function getJSONFile(callback) {
    var interfacePath = '/Approval/ApprovalController/getJSONFile.do?jsonFile=users.json'

    var httpRequest = new XMLHttpRequest()
    httpRequest.onreadystatechange = function() {
        if (httpRequest.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            console.log("Headers -->");
            console.log(httpRequest.getAllResponseHeaders ());
            console.log("Last modified -->");
            console.log(httpRequest.getResponseHeader ("Last-Modified"));
        } else if (httpRequest.readyState === XMLHttpRequest.DONE) {
            console.log('getJSONFile response:' + httpRequest.responseText);
            if (callback) {
                callback(httpRequest.responseText)
            }
        }
    }
    httpRequest.onerror = function() {
        console.log('error')
    }

    var url = server + interfacePath
    url = encodeURI(url)
    httpRequest.open('POST', url)
    httpRequest.send()

    console.log(url)
}

function addNewApprovalEvent(type, createUser, approver, content, attachment, callback) {
    var interfacePath = '/Approval/ApprovalController/addNewApprovalEvent.do'

    var httpRequest = new XMLHttpRequest()
    httpRequest.onreadystatechange = function() {
        if (httpRequest.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            console.log("Headers -->");
            console.log(httpRequest.getAllResponseHeaders ());
            console.log("Last modified -->");
            console.log(httpRequest.getResponseHeader ("Last-Modified"));
        }
        else if (httpRequest.readyState === XMLHttpRequest.DONE) {
            console.log('addNewApprovalEvent response:' + httpRequest.responseText);
            if (callback) {
                callback(httpRequest.responseText)
            }
        }
    }
    httpRequest.onerror = function() {
        console.log('error')
    }

    var url = server + interfacePath
    url += '?eventApprovalType=' + type
    url += '&eventCreateUser=' + JSON.stringify(createUser)
    url += '&eventApprovalPeople=' + JSON.stringify(approver)
    url += '&eventContent=' + content
    url += '&eventApprovalAttachment=' + JSON.stringify(attachment)
    url = encodeURI(url)
    httpRequest.open('POST', url)
    httpRequest.send()

    console.log(url)
}

function selectNeedApprovalEvent(userID, status, callback) {
    var interfacePath = '/Approval/ApprovalController/selectNeedApprovalEvent.do'

    var httpRequest = new XMLHttpRequest()
    httpRequest.onreadystatechange = function() {
        if (httpRequest.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            console.log("Headers -->");
            console.log(httpRequest.getAllResponseHeaders ());
            console.log("Last modified -->");
            console.log(httpRequest.getResponseHeader ("Last-Modified"));
        } else if (httpRequest.readyState === XMLHttpRequest.DONE) {
            console.log('selectNeedApprovalEvent response:' + httpRequest.responseText);
            if (callback) {
                callback(httpRequest.responseText, status)
            }
        }
    }
    httpRequest.onerror = function() {
        console.log('error')
    }

    var url = server + interfacePath
    url += '?approvalUserID=' + userID
    url += '&eventApprovalStatus=' + status
    url = encodeURI(url)
    httpRequest.open('POST', url)
    httpRequest.send()

    console.log(url)
}

function selectMeCreateApprovalEvent(userID, status, callback) {
    var interfacePath = '/Approval/ApprovalController/selectMeCreateApprovalEvent.do'

    var httpRequest = new XMLHttpRequest()
    httpRequest.onreadystatechange = function() {
        if (httpRequest.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            console.log("Headers -->");
            console.log(httpRequest.getAllResponseHeaders ());
            console.log("Last modified -->");
            console.log(httpRequest.getResponseHeader ("Last-Modified"));
        } else if (httpRequest.readyState === XMLHttpRequest.DONE) {
            console.log('selectMeCreateApprovalEvent response:' + httpRequest.responseText);
            if (callback) {
                callback(httpRequest.responseText, status)
            }
        }
    }
    httpRequest.onerror = function() {
        console.log('error')
    }

    var url = server + interfacePath
    url += '?eventCreateUserID=' + userID
    url += '&eventApprovalStatus=' + status
    url = encodeURI(url)
    httpRequest.open('POST', url)
    httpRequest.send()

    console.log(url)
}

function showHasApprovalDetial(eventID, callback) {
    var interfacePath = '/Approval/ApprovalController/showHasApprovalDetial.do'

    var httpRequest = new XMLHttpRequest()
    httpRequest.onreadystatechange = function() {
        if (httpRequest.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            console.log("Headers -->");
            console.log(httpRequest.getAllResponseHeaders ());
            console.log("Last modified -->");
            console.log(httpRequest.getResponseHeader ("Last-Modified"));
        } else if (httpRequest.readyState === XMLHttpRequest.DONE) {
            console.log('showHasApprovalDetial response:' + httpRequest.responseText);
            if (callback) {
                callback(httpRequest.responseText)
            }
        }
    }
    httpRequest.onerror = function() {
        console.log('error')
    }

    var url = server + interfacePath
    url += '?eventID=' + eventID
    url = encodeURI(url)
    httpRequest.open('POST', url)
    httpRequest.send()

    console.log(url)
}

function secFileGetList(userID, approverID, callback) {
    var interfacePath = '/Approval/ApprovalController/secFileGetList.do'

    var httpRequest = new XMLHttpRequest()
    httpRequest.onreadystatechange = function() {
        if (httpRequest.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            console.log("Headers -->");
            console.log(httpRequest.getAllResponseHeaders ());
            console.log("Last modified -->");
            console.log(httpRequest.getResponseHeader ("Last-Modified"));
        } else if (httpRequest.readyState === XMLHttpRequest.DONE) {
            console.log('secFileGetList response:' + httpRequest.responseText);
            if (callback) {
                callback(httpRequest.responseText)
            }
        }
    }
    httpRequest.onerror = function() {
        console.log('error')
    }

    var url = server + interfacePath
    url += '?userID=' + userID
    url += '&approvalUserID=' + approverID
    url = encodeURI(url)
    httpRequest.open('POST', url)
    httpRequest.send()

    console.log(url)
}

function updateApprovalEventStatus(eventID, approvalID, approvalUserID, approvalStatus,
                                   approvalOpinion, nextApprovalUser, fileIDs, callback) {
    var interfacePath = '/Approval/ApprovalController/updateApprovalEventStatus.do'

    var httpRequest = new XMLHttpRequest()
    httpRequest.onreadystatechange = function() {
        if (httpRequest.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            console.log("Headers -->");
            console.log(httpRequest.getAllResponseHeaders ());
            console.log("Last modified -->");
            console.log(httpRequest.getResponseHeader ("Last-Modified"));
        } else if (httpRequest.readyState === XMLHttpRequest.DONE) {
            console.log('updateApprovalEventStatus response:' + httpRequest.responseText);
            if (callback) {
                callback(httpRequest.responseText)
            }
        }
    }
    httpRequest.onerror = function() {
        console.log('error')
    }

    var url = server + interfacePath
    url += '?eventID=' + eventID
    url += '&approvalID=' + approvalID
    url += '&approvalUserID=' + approvalUserID
    url += '&approvalStatus=' + approvalStatus
    url += '&approvalOpinion=' + approvalOpinion
    url += '&nextApprovalUser=' + JSON.stringify(nextApprovalUser)
    url += '&fileIDs=' + fileIDs
    url = encodeURI(url)
    httpRequest.open('POST', url)
    httpRequest.send()

    console.log(url)
}

function userOutAuth(userID, callback) {
    var interfacePath = '/Approval/ApprovalController/userOutAuth.do'

    var httpRequest = new XMLHttpRequest()
    httpRequest.onreadystatechange = function() {
        if (httpRequest.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            console.log("Headers -->");
            console.log(httpRequest.getAllResponseHeaders ());
            console.log("Last modified -->");
            console.log(httpRequest.getResponseHeader ("Last-Modified"));
        } else if (httpRequest.readyState === XMLHttpRequest.DONE) {
            console.log('userOutAuth response:' + httpRequest.responseText);
            if (callback) {
                callback(httpRequest.responseText)
            }
        }
    }
    httpRequest.onerror = function() {
        console.log('error')
    }

    var url = server + interfacePath
    url += '?userID=' + userID
    url = encodeURI(url)
    httpRequest.open('POST', url)
    httpRequest.send()

    console.log(url)
}
