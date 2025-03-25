
Web App included as part of workshop as a sample to invoke InterSystems IRIS APIs from external applications.

# DEVELOPMENT 👨‍💻
This project was generated using [Angular CLI](https://github.com/angular/angular-cli) version 19.1.0.

Instructions for developing in local:

* Install Node

* Install local Angular
```bash
mkdir angular-19
cd angular-19
npm install npm@latest
npm install @angular/cli@19.1.0
```

* Install dependencies
```bash
npm install
```

* Run development server
```bash
ng serve
```

Check http://localhost:4200

# Distribution
```bash
ng build --configuration production
```

# Util: angular cli commands used during development

```bash
ng new sample-webapp --routing=true --style=scss
cd sample-webapp

ng add @angular/material

ng generate module demo --routing

ng generate component demo/order-create

ng generate service demo/order

ng build --configuration production

ng generate service auth

ng generate component login
```