## Overview

[HubSpot ](https://www.hubspot.com/) is an AI-powered customer platform with all the software, integrations, and resources you need to connect your marketing, sales, and customer service. HubSpot's connected platform enables you to grow your business faster by focusing on what matters most: your customers.


[//]: # (TODO: Add overview mentioning the purpose of the module, supported REST API versions, and other high-level details.)


The `hubspot.automation.actions` package offers APIs to connect and interact with [Hubpsot Automation action API](https://developers.hubspot.com/docs/reference/api/automation/custom-workflow-actions) endpoints.

## Setup guide

[//]: # (TODO: Add detailed steps to obtain credentials and configure the module.)
To use the Hubpsot Automation action API connector in Ballerina, you must have a HubSpot developer account.

 ### Step 1: Create a Hubspot Developer Account

Visit the Hubspot portal (https://developers.hubspot.com/get-started) and create a Developer Account.

 ### Step 2: Create a Hubspot Developer Account

Create a Developer Test Account at (https://developers.hubspot.com/beta-docs/getting-started/account-types#developer-test-accounts)

 ### Step 3: Create a Hubspot Develop Test Account

Visit (https://developers.hubspot.com/beta-docs/getting-started/account-types#developer-test-accounts)and create a hubspot developer test account

 ### Step 4: Create a Hubspot Public App

In your developer account, navigate to the "Apps" section.

Click on "Create App" and provide the necessary details, including the app name and description.


 ### Step 5: Initiate the OAuth Flow

Move to the auth tab in the created app and set the permissions there .

Under the OAuth tab you can find the following details ,


client_id: Your app's Client ID.

redirect_uri: The URL users will be redirected to after granting access.

scope: A space-separated list of scopes your app is requesting.

![Auth Tab example](/home/sajeenthiran/projects/module-ballerinax-hubspot.automation.actions/docs/setup/resources/auth.png)


### Step   6: Add the redirect URL
Add your redirect url under the redirect urls.

![Redirect URL ](docs/setup/resources/redirect.png)


### Step   7: Add the Required Scopes

Go to the relevant API documentation (https://developers.hubspot.com/docs/reference/api/automation/custom-workflow-actions) and find out the required scopes.


![Requied Scope doc](docs/setup/resources/scope_doc.png)



Now come back to the Auth Page and add the required scopes under the Auth tab .



![Required Scopes](docs/setup/resources/scopes.png)

Now save the app 

![Save the app](docs/setup/resources/save.png)

### Step   8: Obtain the authorization code 

Copy the App installation url and paste it in the web browser. It wll prompt you to install  the App and then select your deveper test account.

After selcting the developertest account, you will receive a authorization code displalyed in the browser.

![Obtain the authorization code](docs/setup/resources/authorization_code.png)

### Step   9: Obtain the access token


Place your auhtorization code, client_id and client_screct in the folowing comand and execute it in the terminal

'curl --request POST \
  --url https://api.hubapi.com/oauth/v1/token \
  --header 'content-type: application/x-www-form-urlencoded' \
  --data 'grant_type=authorization_code&code=<code>&redirect_uri=http://localhost:9090&client_id=<client_id>&client_secret=<client_secret>'

If the command executes successfully , you will receive the access token from the response.


### Step 10 : Obtaining the developer API key .

Follow the instructions at (https://developers.hubspot.com/docs/api/developer-tools-overview#developer-api-keys)to obtain the developer API key.



## Quickstart 

To begin using the `Hubspot Automation API` connector in your Ballerina application, you'll need to follow these steps:


### Step 1: Import the connector

First, import the `ballerinax/hubspot.automation.actions` package into your Ballerina project.

```ballerina
import ballerinax/hubspot.automation.actions;
```

### Step 2: Instantiate a new connector

Create a `hubspot.automation.actions:ConnectionConfig` object with your domain and developer API token, and initialize the connector.

```ballerina
hubspot.automation.actions:ConnectionConfig automationClient = {
   auth:{

    hapikey:"<developer-api-key>" ,
    private\-app\-legacy: ""
}
};

hubspot.automation.actions:Client automationClient = check new (automationClient);
```

### Step 3: Invoke the connector operation

Utilize the connector's operations to manage extentions and functions.
#### Create an extenstion

```ballerina

hubspot.automation.actions:FieldTypeDefinition typeDefinition = {
    referencedObjectType: "OWNER",
    externalOptions: false,
    externalOptionsReferenceType: "",
    name: "optionsInput",
    'type: "enumeration",
    fieldType: "select",
    optionsUrl: "https://webhook.site/94d09471-6f4c-4a7f-bae2-c9a585dd41e0",
    options: []
};

hubspot.automation.actions:InputFieldDefinition inputFieldDefinition = {
    isRequired: true,
    automationFieldType: "",
    typeDefinition: typeDefinition,
    supportedValueTypes: ["STATIC_VALUE"]
};



hubspot.automation.actions:PublicActionFunction publicActionFunction = {
    functionSource: "exports.main = (event, callback) => {\r\n  callback({\r\n    outputFields: {\r\n      myOutput: \"example output value\"\r\n    }\r\n  });\r\n}",
    functionType: "POST_ACTION_EXECUTION"
};

hubspot.automation.actions:PublicActionDefinitionEgg testingPublicActionDefinitionEgg = {
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




hubspot.automation.actions: PublicActionDefinition response = check automationClient->/automation/v4/actions/[appId].post(testingPublicActionDefinitionEgg);
```

#### List definitions

```ballerina

hubspot.automation.actions : CollectionResponsePublicActionDefinitionForwardPaging response = check automationClient->/automation/v4/actions/[appId];

```

## Examples

The `Hubspot Automation API` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-zendesk/tree/main/examples/), covering the following use cases:

1. [Extension CRUD](https://github.com/ballerina-platform/module-ballerinax-zendesk/tree/main/examples/multi-channel-support-integration) - Perform CRUD operations on Extensions
2. [Call complete callback APIs](https://github.com/ballerina-platform/module-ballerinax-zendesk/tree/main/examples/customer-satisfaction-survey-analysis) - complete callbacks using the  Hubspot API



