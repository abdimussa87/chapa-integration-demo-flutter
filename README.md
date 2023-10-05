# How to Integrate Chapa Payment with a Flutter App and Node.js

This repository contains the source code for a tutorial on how to build a simple e-commerce app with Flutter and Node.js, and integrate Chapa payment gateway to enable online transactions.
You can find the article [here](https://medium.com/@abdimussa87/integrate-chapa-payment-with-a-flutter-app-and-node-js-f7ec69dbf60).

## What is Chapa?

Chapa is a payment gateway that allows you to accept online payments from your customers using multiple payment methods. Chapa supports telebirr, BOA, CBE... and has a simple and secure API. You can learn more about Chapa [here](https://chapa.co).

## What's in this repo?

In this repo we have our Flutter code that displays a list of products and allows the user to buy any product using Chapa.

## How to build it?

Follow the steps in the [tutorial](https://medium.com/@abdimussa87/integrate-chapa-payment-with-a-flutter-app-and-node-js-f7ec69dbf60) to create the project from scratch. The tutorial covers the following topics:

- How to create a Node.js backend with Express and MongoDB
- How to create a Flutter app with go_router, dio, flutter_bloc and other packages
- How to communicate with Chapa API using axios
- How to use webhooks and secret hashes to verify payments
- How to use flutter_inappwebview to open the payment link in the app

## What do you need?

To follow this tutorial, you need:

- Basic knowledge of Flutter and Node.js
- A test account on [Chapa](https://chapa.co)
- Excitement 😁

## How to run the project?

To run the project, you need to do the following:

- Clone this repo and the [Nodejs repo](https://github.com/abdimussa87/chapa-integration-demo-backend) or download them as zip files
- Install the dependencies for both projects with `npm install` and `flutter pub get`
- Create a `.env` file in the Node.js project and add your Chapa test key and webhook secret hash . You can find them in Settings > API section on Chapa dashboard. Also add a dbUrl.
- Run `npm run dev` to start the Node.js server 
- Run `flutter run` to launch the Flutter app on your device or emulator
- Enjoy!

## How to contribute?

If you find any issues or bugs in the code, please feel free to open an issue or submit a pull request. If you have any questions or feedback, please contact me at abdimussa87@gmail.com or on telegram https://t.me/abdimussa93. Thank you! 😊
