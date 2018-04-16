# Hacefrio #

Hacefrio is an API and monitoring interface for a prototype Smart Air
Conditioner.

In its current form, it is a rather minimal Ruby application that provides
just enough functionality to actually be used, but contributions are welcome.

## Running the App ##

In order to run Hacefrio, so far as external, non-ruby dependencies, you will
need both a `redis` instance for data storage and an SMTP account for sending
email. Both of these are configured via environment variables, so it should be
relatively easy to deploy to a PaaS in the same line as Heroku.

Here are all of the values that you can configure via the environment:

* **REDIS_URL** is a URL-style definition for the connection to your redis
* **SECRET** is a key that is used to munge session data
* **HOST** is the canonical hostname for your app
* **NOBI_SECRET** is a key that is used to help generate the secure email links
* **NOBI_EXPIRE** is the number of seconds for which a Nobi secret is valid
* **DEFAULT_FROM** is the email address from which the app will send mail
* **MALONE_URL** is a URL-style definition for the connection to your mail server
* **MALONE_DOMAIN** is the canonical hostname for your app

## Using the API ##

Please see the following wiki pages for an overview of the API endpoints
available:

* [Registering A Device](https://github.com/ess/hacefrio/wiki/Register-A-Device)
* [Updaing A Device's Sensors](https://github.com/ess/hacefrio/wiki/Updating-A-Device%27s-Sensors)
