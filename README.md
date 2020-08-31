# Workshop: IRIS Interoperability Intro
This repository contains the materials and some examples you can use to learn the main ideas involved in InterSystems IRIS Interoperability framework. 

You can find more in-depth information in https://learning.intersystems.com.

# What do you need to install? 
* [Git](https://git-scm.com/downloads) 
* [Docker](https://www.docker.com/products/docker-desktop) (if you are using Windows, make sure you set your Docker installation to use "Linux containers").
* [Docker Compose](https://docs.docker.com/compose/install/)
* [Visual Studio Code](https://code.visualstudio.com/download) + [InterSystems ObjectScript VSCode Extension](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript)

# Setup
Build the image we will use during the workshop:

```console
$ git clone https://github.com/intersystems-ib/workshop-interop-intro
$ cd workshop-interop-intro
$ docker-compose build
$ docker-compose up -d
```

Then, open the `workshop-interop-intro` in your VS Code.

# Examples  

## (a). Start FindRateProduction
* Run the containers we will use in the workshop:
```
docker-compose up -d
```
* Open the [Management Portal](http://localhost:52773/csp/sys/UtilHome.csp).
* Login using the default `superuser`/ `SYS` account.
* *Interoperability > Namespace USER > List > Productions > Demo.Loan.FindRateProduction > Open*
* Start Production
* Have a look at the Business Services, Business Processes and Business Operations.
* Click on the *connector* to see how the components are linked.
* See the *Legend* to understand the meaning of the different colors of the components.

## (b). Test a Business Operation
* Click on `Demo.Loan.WebOperations`
* Go to Actions > Test > Choose a "Demo.Loan.CreditRatingRequest".
* Enter some input and see the output in the resulting Visual Trace.
* Have a look at the involved Business Operation and Messages in VS Code.

## (c). Make a sample loan request
* Open http://localhost:52773/csp/user/DemoLoanForm.csp and enter some data (you can test with different values).
* Go back to your production and open the [Message Viewer](http://localhost:52773/csp/user/EnsPortal.MessageViewer.zen).
* Have a look at the messages, go through some of the traces.
* Pay attention to the elements involved, sync/async calls, message contents and possible errors or alerts thrown.

## (d). Inspect a Business Process
* Click on `Demo.Loan.FindRateDecisionProcessBPL`.
* On the settings tab, click on the magnifyer icon on the *Class name* setting.
* Inspect the graphical BPL definition of the process.
* When you are done, stop the production.

## (e). Start Demo.HL7.MsgRouter.Production
* *Interoperability > Namespace USER > List > Productions > Demo.HL7.MsgRouter.Production > Open*
* Start production.
* Have a look at the production, notice the prebuilt HL7 Business Services and Operations that are being used.
* Explore the settings on those services and operations (e.g. FilePath, etc.)

## (f). Process some sample HL7 messages
* In your VS Code with `workshop-interop-intro` opened, copy `test/*.txt` files into `test/in` subdirectory.
* Go back to the production and see [Message Viewer](http://localhost:52773/csp/user/EnsPortal.MessageViewer.zen).
* Explore some the new messages that have appeared. Notice the HL7 messages.

## (g). Explore routing rules and data transforms
* Click on `XYZ_Router`.
* Click on the magnifying glass on *Business Rule Name* in the Settings Tab.
* Notice the different routing rules based on the content of the HL7 messages.
* Find some of the rules that are using a *Data Transform*.
* Double-click on the Data Transform element and open the *DTL Editor*.
* Have a look at how can messages be transformed.

# Explore more complex scenarios
Have a look at this example where you can see in action a readmission demo scenario using IA in IRIS:
https://github.com/intersystems-community/irisdemo-demo-readmission
