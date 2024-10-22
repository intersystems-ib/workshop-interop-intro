# Workshop: IRIS Interoperability Intro
Have a look at some examples you can use to learn the main ideas involved in InterSystems IRIS Interoperability framework. 

You can find more in-depth information in https://learning.intersystems.com.

# What do you need to install? 
* [Git](https://git-scm.com/downloads) 
* [Docker](https://www.docker.com/products/docker-desktop) (if you are using Windows, make sure you set your Docker installation to use "Linux containers").
* [Docker Compose](https://docs.docker.com/compose/install/)
* [Visual Studio Code](https://code.visualstudio.com/download) + [InterSystems ObjectScript VSCode Extension](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript)

# Setup
Build & run the image we will use during the workshop:

```bash
git clone https://github.com/intersystems-ib/workshop-interop-intro
cd workshop-interop-intro
docker compose build
docker compose up -d
```

Then, open the `workshop-interop-intro` in your VS Code.

# Examples  

## 1. Requesting a loan to different banks
This example is about:
* Receiving a loan request and asking different banks if they would approve or deny this loan
* Wait for different answers and build a response.

Now, check it out by following these steps:
* Open the [Management Portal](http://localhost:52773/csp/sys/UtilHome.csp).
* Login using the default `superuser`/ `SYS` account.
* *Interoperability > Namespace USER > List > Productions > Demo.Loan.FindRateProduction > Open*
* Start Production
* Have a look at the Business Services, Business Processes and Business Operations.
* Click on the *connector* (green ball) to see how the components are linked.
* See the *Legend* to understand the meaning of the different colors of the components.

### Test a Business Operation
* Click on `Demo.Loan.WebOperations`
* Go to *Actions* tab > Test > Choose a `Demo.Loan.CreditRatingRequest` message.
* Enter some input and see the output in the resulting Visual Trace.
* Have a look at the involved Business Operation and Messages in VS Code.

### Make a sample loan request
* Open http://localhost:52773/csp/user/DemoLoanForm.csp and enter some data (you can test with different values).
* Go back to your production and open the [Message Viewer](http://localhost:52773/csp/user/EnsPortal.MessageViewer.zen).
* Have a look at the messages, go through some of the traces.
* Pay attention to the elements involved, sync/async calls, message contents and possible errors or alerts thrown.

### Inspect a Business Process
* Back in [Demo.Loan.FindRateProduction Production](http://localhost:52773/csp/user/EnsPortal.ProductionConfig.zen?PRODUCTION=Demo.Loan.FindRateProduction), click on `Demo.Loan.FindRateDecisionProcessBPL`.
* On the settings tab, click on the magnifyer icon on the *Class name* setting.
* Inspect the graphical BPL definition of the process.
* When you are done, stop the production.

## 2. HL7 messages handling
This example is about showing how to handle some ADT and ORM HL7 messages.
If you are really interested in Healthcare interoperability check out [workshop-healthcare-interop](https://github.com/intersystems-ib/workshop-healthcare-interop)

* *Interoperability > Namespace USER > List > Productions > Demo.HL7.MsgRouter.Production > Open*
* Start production.
* Have a look at the production, notice the prebuilt HL7 Business Services and Operations that are being used.
* Explore the settings on those services and operations (e.g. FilePath, etc.)

### Process some sample HL7 messages
* In your VS Code with `workshop-interop-intro` opened, copy `test/*.txt` files into `test/in` subdirectory.
* Go back to the production and see [Message Viewer](http://localhost:52773/csp/user/EnsPortal.MessageViewer.zen).
* Explore some the new messages that have appeared. Notice the HL7 messages.

### Explore routing rules and data transforms
* Back in Demo.HL7.MsgRouter.Production Production configuration page, click on `XYZ_Router`.
* Click on the magnifying glass on *Business Rule Name* in the Settings Tab.
* Notice the different routing rules based on the content of the HL7 messages.
* Find some of the rules that are using a *Data Transform*.
* Double-click on the Data Transform element and open the *DTL Editor*.
* Have a look at how can messages be transformed.

## 3. Handling Orders in CSV and querying to external database
This example is about processing an incoming CSV order, complete customer information by querying an external MySQL database and sending a message to an API interface.

For this example, a sample MySQL database has already been setup for you. If you want to check it out you can do the following:
```bash
docker exec -it mysql bash
mysql --host=localhost --user=testuser testdb -p # use "testpassword"
select * from customer;
```

```console
mysql> select * From customer;
+------------+------------------------+-----------------+
| CustomerID | CustomerName           | CustomerSegment |
+------------+------------------------+-----------------+
|          2 | Janice Fletcher        | Corporate       |
|          3 | Bonnie Potter          | Corporate       |
|          5 | Ronnie Proctor         | Home Office     |
|          6 | Dwight Hwang           | Home Office     |
|          6 | Dwight Hwang           | Home Office     |
|          7 | Leon Gill              | Home Office     |
|          8 | Melanie Garner         | Home Office     |
|          9 | Lorraine Houston       | Home Office     |
|         10 | Meredith Norris Thomas | Home Office     |
|         11 | Marcus Dunlap          | Home Office     |
|         12 | Kara Pace              | Home Office     |
|         14 | Gwendolyn F Tyson      | Small Business  |
|         15 | Timothy Reese          | Small Business  |
|         16 | Sarah Ramsey           | Small Business  |
|         17 | Florence Hsu Schwarz   | Small Business  |
|         18 | Laurie Hanna           | Small Business  |
|         19 | Jim Rodgers            | Small Business  |
|         20 | Marion Nolan Kaplan    | Small Business  |
|         21 | Tony Wilkins Winters   | Small Business  |
|         23 | Lynn Moss              | Corporate       |
|         24 | Edna Thomas            | Corporate       |
|         25 | Virginia Hardison      | Corporate       |
|         26 | Marguerite Kane        | Corporate       |
|         27 | Guy Gallagher          | Corporate       |
|         28 | Ronnie McNamara        | Corporate       |
|         29 | Elizabeth Walker       | Corporate       |
|         31 | Alice Capps            | Corporate       |
+------------+------------------------+-----------------+
```

* *Interoperability > Namespace USER > List > Productions > Demo.Order.Production > Open*
* Start production.

### Process some a sample CSV message
* In your VS Code with `workshop-interop-intro` opened, copy `test/*.csv` files into `test/in` subdirectory.
* Go back to the production and see [Message Viewer](http://localhost:52773/csp/user/EnsPortal.MessageViewer.zen).
* Explore some the new messages that have appeared.
