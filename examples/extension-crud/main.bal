import ballerinax/hubspot.automation.actions;
import ballerina/io;
configurable string apiKey=?;
public function main() returns error? {
     // BearerTokenConfig
   // API Key Config
actions:ConnectionConfig apikeyConfig = {auth:{

    hapikey: apiKey, 
    private\-app\-legacy: ""
}};



    // Client instatilization   
    final actions:Client hubspotAutomation = check new actions:Client(apikeyConfig);

// sample extension definition

string createdExtensionId = "";
int:Signed32 appId=5712614;

actions:FieldTypeDefinition typeDefinition = {
    referencedObjectType: "OWNER",
    externalOptions: false,
    externalOptionsReferenceType: "",
    name: "optionsInput",
    'type: "enumeration",
    fieldType: "select",
    optionsUrl: "https://webhook.site/94d09471-6f4c-4a7f-bae2-c9a585dd41e0",
    options: []
};

actions:InputFieldDefinition inputFieldDefinition = {
    isRequired: true,
    automationFieldType: "",
    typeDefinition: typeDefinition,
    supportedValueTypes: ["STATIC_VALUE"]
};



actions:PublicActionFunction publicActionFunction = {
    functionSource: "exports.main = (event, callback) => {\r\n  callback({\r\n    outputFields: {\r\n      myOutput: \"example output value\"\r\n    }\r\n  });\r\n}",
    functionType: "POST_ACTION_EXECUTION"
};

actions:PublicActionDefinitionEgg testingPublicActionDefinitionEgg = {
    inputFields: [inputFieldDefinition],
    actionUrl: "https://webhook.site/94d09471-6f4c-4a7f-bae2-c9a585dd41e0",
    published: false,
    objectTypes: ["CONTACT"],
    objectRequestOptions: { properties: ["email"] },
    functions: [publicActionFunction],
    labels: {
        "en": {
            "inputFieldLabels": {
                "staticInput": "Static Input",
                "objectInput": "Object Property Input",
                "optionsInput": "External Options Input"
            },
            "actionName": "My Extension",
            "actionDescription": "My Extension Description",
            "appDisplayName": "My App Display Name",
            "actionCardContent": "My Action Card Content"
        }
    }
};

// Create Extension
    actions:PublicActionDefinition response = check hubspotAutomation->/automation/v4/actions/[appId].post(testingPublicActionDefinitionEgg);
    createdExtensionId = response.id;
    io:print("Extension Created with ID: " + createdExtensionId+ "\n");


// Get Extension
    actions:PublicActionDefinition getResponse = check hubspotAutomation->/automation/v4/actions/[appId]/[createdExtensionId].get();

    io:print("Extension Retrieved: " + getResponse.id + "\n");

// Update Extension
    actions:PublicActionDefinition updateResponse = check hubspotAutomation->/automation/v4/actions/[appId]/[createdExtensionId];
    io:print("Extension Updated: ");
    io:print(updateResponse);
    io:println("\n");


// Delete Extension
    var deleteResponse = check hubspotAutomation->/automation/v4/actions/[appId]/[createdExtensionId].delete();
    io:println("Extension Deleted");
    
}