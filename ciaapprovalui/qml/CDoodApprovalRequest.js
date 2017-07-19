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
            if (callback) {
                callback(httpRequest.responseText)
            }
            console.log(httpRequest.responseText);
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
            if (callback) {
                callback(httpRequest.responseText)
            }
            console.log(httpRequest.responseText);
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
            if (callback) {
                callback(httpRequest.responseText)
            }
            console.log(httpRequest.responseText);
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
            console.log('response:' + httpRequest.responseText);
            if (callback) {
                callback(httpRequest.responseText)
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
            console.log('response:' + httpRequest.responseText);
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
            console.log('response:' + httpRequest.responseText);
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
